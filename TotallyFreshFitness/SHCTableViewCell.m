//
//  SHCTableViewCell.m
//  Total Fitness And Nutrition
//
//  Created by Harveer Parmar on 2014-05-15.
//  Copyright (c) 2014 Total Fitness and Nutrition. All rights reserved.
//

#import "SHCTableViewCell.h"
#import "SHCStrikethroughLabel.h"
#import <QuartzCore/QuartzCore.h>

@implementation SHCTableViewCell{
    CAGradientLayer* _gradientLayer;
	CGPoint _originalCenter;
    BOOL _deleteOnDragRelease;
	SHCStrikethroughLabel *_label;
	CALayer *_itemCompleteLayer;
	BOOL _markCompleteOnDragRelease;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *groceryListImageView         = [[UIImageView alloc] initWithFrame: CGRectMake(0,0,110,80)];
        groceryListImageView.tag                  = 1; // Need to add outside the if statment
        [self addSubview:groceryListImageView];
        
        CGRect frame                              = CGRectMake(240, 20, 70, 50);
        // checkButton
        UIButton *checkButton                     = [[UIButton alloc] initWithFrame:frame];
        checkButton.tag                           = 3;
        // Add image to the butt
        [self addSubview:checkButton];
        
        // Position after image and is the only text
        // for the name of the food item
        UILabel *groceryListTextLabel             = [[UILabel alloc] initWithFrame:CGRectMake(120, 0, 150, 60)];
        groceryListTextLabel.font                 = [UIFont customFontWithSize:15];
        groceryListTextLabel.lineBreakMode        = NSLineBreakByWordWrapping;
        groceryListTextLabel.numberOfLines        = 3;
        groceryListTextLabel.textAlignment        = NSTextAlignmentLeft;
        groceryListTextLabel.textColor            = [UIColor blackColor];
        groceryListTextLabel.tag                  = 2; // Need to add outside the if statment
        [self addSubview:groceryListTextLabel];
        
        // create a label that renders the todo item text
		_label = [[SHCStrikethroughLabel alloc] initWithFrame:CGRectNull];
		_label.textColor = [UIColor whiteColor];
		_label.font = [UIFont boldSystemFontOfSize:16];
		_label.backgroundColor = [UIColor clearColor];
		[self addSubview:_label];
        
		// remove the default blue highlight for selected cells
		self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // add a layer that overlays the cell adding a subtle gradient effect
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.frame = self.bounds;
        _gradientLayer.colors = @[(id)[[UIColor colorWithWhite:1.0f alpha:0.2f] CGColor],
                                  (id)[[UIColor colorWithWhite:1.0f alpha:0.1f] CGColor],
                                  (id)[[UIColor clearColor] CGColor],
                                  (id)[[UIColor colorWithWhite:0.0f alpha:0.1f] CGColor]];
        _gradientLayer.locations = @[@0.00f, @0.01f, @0.95f, @1.00f];
        [self.layer insertSublayer:_gradientLayer atIndex:0];
		// add a layer that renders a green background when an item is complete
		_itemCompleteLayer = [CALayer layer];
		_itemCompleteLayer.backgroundColor = [[[UIColor alloc] initWithRed:0.0 green:0.6 blue:0.0 alpha:1.0] CGColor];
		_itemCompleteLayer.hidden = NO;
		[self.layer insertSublayer:_itemCompleteLayer atIndex:0];
		// add a pan recognizer
		UIGestureRecognizer* recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
		recognizer.delegate = self;
		[self addGestureRecognizer:recognizer];
        
        
    }
    return self;
}

const float LABEL_LEFT_MARGIN = 15.0f;

-(void)layoutSubviews {
    [super layoutSubviews];
    // ensure the gradient layers occupies the full bounds
    _gradientLayer.frame = self.bounds;
    _itemCompleteLayer.frame = self.bounds;
    _label.frame = CGRectMake(LABEL_LEFT_MARGIN, 0,
                              self.bounds.size.width - LABEL_LEFT_MARGIN,self.bounds.size.height);
}

-(void)setTodoItem:(SHCToDoItem *)todoItem {
    _toDoItem = todoItem;
    // we must update all the visual state associated with the model item
    _label.text = todoItem.text;
    _label.strikethrough = todoItem.completed;
    _itemCompleteLayer.hidden = !todoItem.completed;
}

#pragma mark - horizontal pan gesture methods
-(BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:[self superview]];
    // Check for horizontal gesture
    if (fabsf(translation.x) > fabsf(translation.y)) {
        return YES;
    }
    return NO;
}

-(void)handlePan:(UIPanGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
		// if the gesture has just started, record the current centre location
        _originalCenter = self.center;
    }
    
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        // translate the center
        CGPoint translation = [recognizer translationInView:self];
        self.center = CGPointMake(_originalCenter.x + translation.x, _originalCenter.y);
        // determine whether the item has been dragged far enough to initiate a delete / complete
        _markCompleteOnDragRelease = self.frame.origin.x > self.frame.size.width / 2;
    }
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        // the frame this cell would have had before being dragged
        CGRect originalFrame = CGRectMake(0, self.frame.origin.y,
                                          self.bounds.size.width, self.bounds.size.height);
        if (!_deleteOnDragRelease) {
            // if the item is not being deleted, snap back to the original location
            [UIView animateWithDuration:0.2
                             animations:^{
                                 self.frame = originalFrame;
                             }
             ];
        }
        if (_markCompleteOnDragRelease) {
            // mark the item as complete and update the UI state
            self.toDoItem.completed = YES;
            _itemCompleteLayer.hidden = NO;
            _label.strikethrough = YES;
        }
    }
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
