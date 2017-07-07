.class public Landroid/support/design/widget/BottomSheetBehavior;
.super Landroid/support/design/widget/CoordinatorLayout$Behavior;
.source "BottomSheetBehavior.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroid/support/design/widget/BottomSheetBehavior$SavedState;,
        Landroid/support/design/widget/BottomSheetBehavior$SettleRunnable;,
        Landroid/support/design/widget/BottomSheetBehavior$State;,
        Landroid/support/design/widget/BottomSheetBehavior$BottomSheetCallback;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<V:",
        "Landroid/view/View;",
        ">",
        "Landroid/support/design/widget/CoordinatorLayout$Behavior",
        "<TV;>;"
    }
.end annotation


# static fields
.field private static final HIDE_FRICTION:F = 0.1f

.field private static final HIDE_THRESHOLD:F = 0.5f

.field public static final STATE_COLLAPSED:I = 0x4

.field public static final STATE_DRAGGING:I = 0x1

.field public static final STATE_EXPANDED:I = 0x3

.field public static final STATE_HIDDEN:I = 0x5

.field public static final STATE_SETTLING:I = 0x2


# instance fields
.field private mActivePointerId:I

.field private mCallback:Landroid/support/design/widget/BottomSheetBehavior$BottomSheetCallback;

.field private final mDragCallback:Landroid/support/v4/widget/ViewDragHelper$Callback;

.field private mHideable:Z

.field private mIgnoreEvents:Z

.field private mInitialY:I

.field private mLastNestedScrollDy:I

.field private mMaxOffset:I

.field private mMaximumVelocity:F

.field private mMinOffset:I

.field private mNestedScrolled:Z

.field private mNestedScrollingChildRef:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference",
            "<",
            "Landroid/view/View;",
            ">;"
        }
    .end annotation
.end field

.field private mParentHeight:I

.field private mPeekHeight:I

.field private mSkipCollapsed:Z

.field private mState:I

.field private mTouchingScrollingChild:Z

.field private mVelocityTracker:Landroid/view/VelocityTracker;

.field private mViewDragHelper:Landroid/support/v4/widget/ViewDragHelper;

.field private mViewRef:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference",
            "<TV;>;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 153
    .local p0, "this":Landroid/support/design/widget/BottomSheetBehavior;, "Landroid/support/design/widget/BottomSheetBehavior<TV;>;"
    invoke-direct {p0}, Landroid/support/design/widget/CoordinatorLayout$Behavior;-><init>()V

    .line 123
    const/4 v0, 0x4

    iput v0, p0, Landroid/support/design/widget/BottomSheetBehavior;->mState:I

    .line 567
    new-instance v0, Landroid/support/design/widget/BottomSheetBehavior$1;

    invoke-direct {v0, p0}, Landroid/support/design/widget/BottomSheetBehavior$1;-><init>(Landroid/support/design/widget/BottomSheetBehavior;)V

    iput-object v0, p0, Landroid/support/design/widget/BottomSheetBehavior;->mDragCallback:Landroid/support/v4/widget/ViewDragHelper$Callback;

    .line 154
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 4
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;

    .prologue
    .local p0, "this":Landroid/support/design/widget/BottomSheetBehavior;, "Landroid/support/design/widget/BottomSheetBehavior<TV;>;"
    const/4 v3, 0x0

    .line 163
    invoke-direct {p0, p1, p2}, Landroid/support/design/widget/CoordinatorLayout$Behavior;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 123
    const/4 v2, 0x4

    iput v2, p0, Landroid/support/design/widget/BottomSheetBehavior;->mState:I

    .line 567
    new-instance v2, Landroid/support/design/widget/BottomSheetBehavior$1;

    invoke-direct {v2, p0}, Landroid/support/design/widget/BottomSheetBehavior$1;-><init>(Landroid/support/design/widget/BottomSheetBehavior;)V

    iput-object v2, p0, Landroid/support/design/widget/BottomSheetBehavior;->mDragCallback:Landroid/support/v4/widget/ViewDragHelper$Callback;

    .line 164
    sget-object v2, Landroid/support/design/R$styleable;->BottomSheetBehavior_Layout:[I

    invoke-virtual {p1, p2, v2}, Landroid/content/Context;->obtainStyledAttributes(Landroid/util/AttributeSet;[I)Landroid/content/res/TypedArray;

    move-result-object v0

    .line 166
    .local v0, "a":Landroid/content/res/TypedArray;
    sget v2, Landroid/support/design/R$styleable;->BottomSheetBehavior_Layout_behavior_peekHeight:I

    invoke-virtual {v0, v2, v3}, Landroid/content/res/TypedArray;->getDimensionPixelSize(II)I

    move-result v2

    invoke-virtual {p0, v2}, Landroid/support/design/widget/BottomSheetBehavior;->setPeekHeight(I)V

    .line 168
    sget v2, Landroid/support/design/R$styleable;->BottomSheetBehavior_Layout_behavior_hideable:I

    invoke-virtual {v0, v2, v3}, Landroid/content/res/TypedArray;->getBoolean(IZ)Z

    move-result v2

    invoke-virtual {p0, v2}, Landroid/support/design/widget/BottomSheetBehavior;->setHideable(Z)V

    .line 169
    sget v2, Landroid/support/design/R$styleable;->BottomSheetBehavior_Layout_behavior_skipCollapsed:I

    invoke-virtual {v0, v2, v3}, Landroid/content/res/TypedArray;->getBoolean(IZ)Z

    move-result v2

    invoke-virtual {p0, v2}, Landroid/support/design/widget/BottomSheetBehavior;->setSkipCollapsed(Z)V

    .line 171
    invoke-virtual {v0}, Landroid/content/res/TypedArray;->recycle()V

    .line 172
    invoke-static {p1}, Landroid/view/ViewConfiguration;->get(Landroid/content/Context;)Landroid/view/ViewConfiguration;

    move-result-object v1

    .line 173
    .local v1, "configuration":Landroid/view/ViewConfiguration;
    invoke-virtual {v1}, Landroid/view/ViewConfiguration;->getScaledMaximumFlingVelocity()I

    move-result v2

    int-to-float v2, v2

    iput v2, p0, Landroid/support/design/widget/BottomSheetBehavior;->mMaximumVelocity:F

    .line 174
    return-void
.end method

.method static synthetic access$000(Landroid/support/design/widget/BottomSheetBehavior;)I
    .locals 1
    .param p0, "x0"    # Landroid/support/design/widget/BottomSheetBehavior;

    .prologue
    .line 50
    iget v0, p0, Landroid/support/design/widget/BottomSheetBehavior;->mState:I

    return v0
.end method

.method static synthetic access$100(Landroid/support/design/widget/BottomSheetBehavior;)Z
    .locals 1
    .param p0, "x0"    # Landroid/support/design/widget/BottomSheetBehavior;

    .prologue
    .line 50
    iget-boolean v0, p0, Landroid/support/design/widget/BottomSheetBehavior;->mTouchingScrollingChild:Z

    return v0
.end method

.method static synthetic access$1000(Landroid/support/design/widget/BottomSheetBehavior;)I
    .locals 1
    .param p0, "x0"    # Landroid/support/design/widget/BottomSheetBehavior;

    .prologue
    .line 50
    iget v0, p0, Landroid/support/design/widget/BottomSheetBehavior;->mParentHeight:I

    return v0
.end method

.method static synthetic access$1100(Landroid/support/design/widget/BottomSheetBehavior;)I
    .locals 1
    .param p0, "x0"    # Landroid/support/design/widget/BottomSheetBehavior;

    .prologue
    .line 50
    iget v0, p0, Landroid/support/design/widget/BottomSheetBehavior;->mMaxOffset:I

    return v0
.end method

.method static synthetic access$1200(Landroid/support/design/widget/BottomSheetBehavior;)Landroid/support/v4/widget/ViewDragHelper;
    .locals 1
    .param p0, "x0"    # Landroid/support/design/widget/BottomSheetBehavior;

    .prologue
    .line 50
    iget-object v0, p0, Landroid/support/design/widget/BottomSheetBehavior;->mViewDragHelper:Landroid/support/v4/widget/ViewDragHelper;

    return-object v0
.end method

.method static synthetic access$200(Landroid/support/design/widget/BottomSheetBehavior;)I
    .locals 1
    .param p0, "x0"    # Landroid/support/design/widget/BottomSheetBehavior;

    .prologue
    .line 50
    iget v0, p0, Landroid/support/design/widget/BottomSheetBehavior;->mActivePointerId:I

    return v0
.end method

.method static synthetic access$300(Landroid/support/design/widget/BottomSheetBehavior;)Ljava/lang/ref/WeakReference;
    .locals 1
    .param p0, "x0"    # Landroid/support/design/widget/BottomSheetBehavior;

    .prologue
    .line 50
    iget-object v0, p0, Landroid/support/design/widget/BottomSheetBehavior;->mNestedScrollingChildRef:Ljava/lang/ref/WeakReference;

    return-object v0
.end method

.method static synthetic access$400(Landroid/support/design/widget/BottomSheetBehavior;)Ljava/lang/ref/WeakReference;
    .locals 1
    .param p0, "x0"    # Landroid/support/design/widget/BottomSheetBehavior;

    .prologue
    .line 50
    iget-object v0, p0, Landroid/support/design/widget/BottomSheetBehavior;->mViewRef:Ljava/lang/ref/WeakReference;

    return-object v0
.end method

.method static synthetic access$500(Landroid/support/design/widget/BottomSheetBehavior;I)V
    .locals 0
    .param p0, "x0"    # Landroid/support/design/widget/BottomSheetBehavior;
    .param p1, "x1"    # I

    .prologue
    .line 50
    invoke-direct {p0, p1}, Landroid/support/design/widget/BottomSheetBehavior;->dispatchOnSlide(I)V

    return-void
.end method

.method static synthetic access$600(Landroid/support/design/widget/BottomSheetBehavior;I)V
    .locals 0
    .param p0, "x0"    # Landroid/support/design/widget/BottomSheetBehavior;
    .param p1, "x1"    # I

    .prologue
    .line 50
    invoke-direct {p0, p1}, Landroid/support/design/widget/BottomSheetBehavior;->setStateInternal(I)V

    return-void
.end method

.method static synthetic access$700(Landroid/support/design/widget/BottomSheetBehavior;)I
    .locals 1
    .param p0, "x0"    # Landroid/support/design/widget/BottomSheetBehavior;

    .prologue
    .line 50
    iget v0, p0, Landroid/support/design/widget/BottomSheetBehavior;->mMinOffset:I

    return v0
.end method

.method static synthetic access$800(Landroid/support/design/widget/BottomSheetBehavior;)Z
    .locals 1
    .param p0, "x0"    # Landroid/support/design/widget/BottomSheetBehavior;

    .prologue
    .line 50
    iget-boolean v0, p0, Landroid/support/design/widget/BottomSheetBehavior;->mHideable:Z

    return v0
.end method

.method static synthetic access$900(Landroid/support/design/widget/BottomSheetBehavior;Landroid/view/View;F)Z
    .locals 1
    .param p0, "x0"    # Landroid/support/design/widget/BottomSheetBehavior;
    .param p1, "x1"    # Landroid/view/View;
    .param p2, "x2"    # F

    .prologue
    .line 50
    invoke-direct {p0, p1, p2}, Landroid/support/design/widget/BottomSheetBehavior;->shouldHide(Landroid/view/View;F)Z

    move-result v0

    return v0
.end method

.method private dispatchOnSlide(I)V
    .locals 5
    .param p1, "top"    # I

    .prologue
    .line 652
    .local p0, "this":Landroid/support/design/widget/BottomSheetBehavior;, "Landroid/support/design/widget/BottomSheetBehavior<TV;>;"
    iget-object v1, p0, Landroid/support/design/widget/BottomSheetBehavior;->mViewRef:Ljava/lang/ref/WeakReference;

    invoke-virtual {v1}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    .line 653
    .local v0, "bottomSheet":Landroid/view/View;
    if-eqz v0, :cond_0

    iget-object v1, p0, Landroid/support/design/widget/BottomSheetBehavior;->mCallback:Landroid/support/design/widget/BottomSheetBehavior$BottomSheetCallback;

    if-eqz v1, :cond_0

    .line 654
    iget v1, p0, Landroid/support/design/widget/BottomSheetBehavior;->mMaxOffset:I

    if-le p1, v1, :cond_1

    .line 655
    iget-object v1, p0, Landroid/support/design/widget/BottomSheetBehavior;->mCallback:Landroid/support/design/widget/BottomSheetBehavior$BottomSheetCallback;

    iget v2, p0, Landroid/support/design/widget/BottomSheetBehavior;->mMaxOffset:I

    sub-int/2addr v2, p1

    int-to-float v2, v2

    iget v3, p0, Landroid/support/design/widget/BottomSheetBehavior;->mPeekHeight:I

    int-to-float v3, v3

    div-float/2addr v2, v3

    invoke-virtual {v1, v0, v2}, Landroid/support/design/widget/BottomSheetBehavior$BottomSheetCallback;->onSlide(Landroid/view/View;F)V

    .line 661
    :cond_0
    :goto_0
    return-void

    .line 657
    :cond_1
    iget-object v1, p0, Landroid/support/design/widget/BottomSheetBehavior;->mCallback:Landroid/support/design/widget/BottomSheetBehavior$BottomSheetCallback;

    iget v2, p0, Landroid/support/design/widget/BottomSheetBehavior;->mMaxOffset:I

    sub-int/2addr v2, p1

    int-to-float v2, v2

    iget v3, p0, Landroid/support/design/widget/BottomSheetBehavior;->mMaxOffset:I

    iget v4, p0, Landroid/support/design/widget/BottomSheetBehavior;->mMinOffset:I

    sub-int/2addr v3, v4

    int-to-float v3, v3

    div-float/2addr v2, v3

    invoke-virtual {v1, v0, v2}, Landroid/support/design/widget/BottomSheetBehavior$BottomSheetCallback;->onSlide(Landroid/view/View;F)V

    goto :goto_0
.end method

.method private findScrollingChild(Landroid/view/View;)Landroid/view/View;
    .locals 5
    .param p1, "view"    # Landroid/view/View;

    .prologue
    .line 547
    .local p0, "this":Landroid/support/design/widget/BottomSheetBehavior;, "Landroid/support/design/widget/BottomSheetBehavior<TV;>;"
    instance-of v4, p1, Landroid/support/v4/view/NestedScrollingChild;

    if-eqz v4, :cond_0

    .line 559
    .end local p1    # "view":Landroid/view/View;
    :goto_0
    return-object p1

    .line 550
    .restart local p1    # "view":Landroid/view/View;
    :cond_0
    instance-of v4, p1, Landroid/view/ViewGroup;

    if-eqz v4, :cond_2

    move-object v1, p1

    .line 551
    check-cast v1, Landroid/view/ViewGroup;

    .line 552
    .local v1, "group":Landroid/view/ViewGroup;
    const/4 v2, 0x0

    .local v2, "i":I
    invoke-virtual {v1}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v0

    .local v0, "count":I
    :goto_1
    if-ge v2, v0, :cond_2

    .line 553
    invoke-virtual {v1, v2}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v4

    invoke-direct {p0, v4}, Landroid/support/design/widget/BottomSheetBehavior;->findScrollingChild(Landroid/view/View;)Landroid/view/View;

    move-result-object v3

    .line 554
    .local v3, "scrollingChild":Landroid/view/View;
    if-eqz v3, :cond_1

    move-object p1, v3

    .line 555
    goto :goto_0

    .line 552
    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 559
    .end local v0    # "count":I
    .end local v1    # "group":Landroid/view/ViewGroup;
    .end local v2    # "i":I
    .end local v3    # "scrollingChild":Landroid/view/View;
    :cond_2
    const/4 p1, 0x0

    goto :goto_0
.end method

.method public static from(Landroid/view/View;)Landroid/support/design/widget/BottomSheetBehavior;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<V:",
            "Landroid/view/View;",
            ">(TV;)",
            "Landroid/support/design/widget/BottomSheetBehavior",
            "<TV;>;"
        }
    .end annotation

    .prologue
    .line 732
    .local p0, "view":Landroid/view/View;, "TV;"
    invoke-virtual {p0}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v1

    .line 733
    .local v1, "params":Landroid/view/ViewGroup$LayoutParams;
    instance-of v2, v1, Landroid/support/design/widget/CoordinatorLayout$LayoutParams;

    if-nez v2, :cond_0

    .line 734
    new-instance v2, Ljava/lang/IllegalArgumentException;

    const-string v3, "The view is not a child of CoordinatorLayout"

    invoke-direct {v2, v3}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 736
    :cond_0
    check-cast v1, Landroid/support/design/widget/CoordinatorLayout$LayoutParams;

    .line 737
    .end local v1    # "params":Landroid/view/ViewGroup$LayoutParams;
    invoke-virtual {v1}, Landroid/support/design/widget/CoordinatorLayout$LayoutParams;->getBehavior()Landroid/support/design/widget/CoordinatorLayout$Behavior;

    move-result-object v0

    .line 738
    .local v0, "behavior":Landroid/support/design/widget/CoordinatorLayout$Behavior;
    instance-of v2, v0, Landroid/support/design/widget/BottomSheetBehavior;

    if-nez v2, :cond_1

    .line 739
    new-instance v2, Ljava/lang/IllegalArgumentException;

    const-string v3, "The view is not associated with BottomSheetBehavior"

    invoke-direct {v2, v3}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 742
    :cond_1
    check-cast v0, Landroid/support/design/widget/BottomSheetBehavior;

    .end local v0    # "behavior":Landroid/support/design/widget/CoordinatorLayout$Behavior;
    return-object v0
.end method

.method private getYVelocity()F
    .locals 3

    .prologue
    .line 563
    .local p0, "this":Landroid/support/design/widget/BottomSheetBehavior;, "Landroid/support/design/widget/BottomSheetBehavior<TV;>;"
    iget-object v0, p0, Landroid/support/design/widget/BottomSheetBehavior;->mVelocityTracker:Landroid/view/VelocityTracker;

    const/16 v1, 0x3e8

    iget v2, p0, Landroid/support/design/widget/BottomSheetBehavior;->mMaximumVelocity:F

    invoke-virtual {v0, v1, v2}, Landroid/view/VelocityTracker;->computeCurrentVelocity(IF)V

    .line 564
    iget-object v0, p0, Landroid/support/design/widget/BottomSheetBehavior;->mVelocityTracker:Landroid/view/VelocityTracker;

    iget v1, p0, Landroid/support/design/widget/BottomSheetBehavior;->mActivePointerId:I

    invoke-static {v0, v1}, Landroid/support/v4/view/VelocityTrackerCompat;->getYVelocity(Landroid/view/VelocityTracker;I)F

    move-result v0

    return v0
.end method

.method private reset()V
    .locals 1

    .prologue
    .line 527
    .local p0, "this":Landroid/support/design/widget/BottomSheetBehavior;, "Landroid/support/design/widget/BottomSheetBehavior<TV;>;"
    const/4 v0, -0x1

    iput v0, p0, Landroid/support/design/widget/BottomSheetBehavior;->mActivePointerId:I

    .line 528
    iget-object v0, p0, Landroid/support/design/widget/BottomSheetBehavior;->mVelocityTracker:Landroid/view/VelocityTracker;

    if-eqz v0, :cond_0

    .line 529
    iget-object v0, p0, Landroid/support/design/widget/BottomSheetBehavior;->mVelocityTracker:Landroid/view/VelocityTracker;

    invoke-virtual {v0}, Landroid/view/VelocityTracker;->recycle()V

    .line 530
    const/4 v0, 0x0

    iput-object v0, p0, Landroid/support/design/widget/BottomSheetBehavior;->mVelocityTracker:Landroid/view/VelocityTracker;

    .line 532
    :cond_0
    return-void
.end method

.method private setStateInternal(I)V
    .locals 2
    .param p1, "state"    # I

    .prologue
    .line 516
    .local p0, "this":Landroid/support/design/widget/BottomSheetBehavior;, "Landroid/support/design/widget/BottomSheetBehavior<TV;>;"
    iget v1, p0, Landroid/support/design/widget/BottomSheetBehavior;->mState:I

    if-ne v1, p1, :cond_1

    .line 524
    :cond_0
    :goto_0
    return-void

    .line 519
    :cond_1
    iput p1, p0, Landroid/support/design/widget/BottomSheetBehavior;->mState:I

    .line 520
    iget-object v1, p0, Landroid/support/design/widget/BottomSheetBehavior;->mViewRef:Ljava/lang/ref/WeakReference;

    invoke-virtual {v1}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    .line 521
    .local v0, "bottomSheet":Landroid/view/View;
    if-eqz v0, :cond_0

    iget-object v1, p0, Landroid/support/design/widget/BottomSheetBehavior;->mCallback:Landroid/support/design/widget/BottomSheetBehavior$BottomSheetCallback;

    if-eqz v1, :cond_0

    .line 522
    iget-object v1, p0, Landroid/support/design/widget/BottomSheetBehavior;->mCallback:Landroid/support/design/widget/BottomSheetBehavior$BottomSheetCallback;

    invoke-virtual {v1, v0, p1}, Landroid/support/design/widget/BottomSheetBehavior$BottomSheetCallback;->onStateChanged(Landroid/view/View;I)V

    goto :goto_0
.end method

.method private shouldHide(Landroid/view/View;F)Z
    .locals 5
    .param p1, "child"    # Landroid/view/View;
    .param p2, "yvel"    # F

    .prologue
    .local p0, "this":Landroid/support/design/widget/BottomSheetBehavior;, "Landroid/support/design/widget/BottomSheetBehavior<TV;>;"
    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 535
    iget-boolean v3, p0, Landroid/support/design/widget/BottomSheetBehavior;->mSkipCollapsed:Z

    if-eqz v3, :cond_1

    .line 543
    :cond_0
    :goto_0
    return v1

    .line 538
    :cond_1
    invoke-virtual {p1}, Landroid/view/View;->getTop()I

    move-result v3

    iget v4, p0, Landroid/support/design/widget/BottomSheetBehavior;->mMaxOffset:I

    if-ge v3, v4, :cond_2

    move v1, v2

    .line 540
    goto :goto_0

    .line 542
    :cond_2
    invoke-virtual {p1}, Landroid/view/View;->getTop()I

    move-result v3

    int-to-float v3, v3

    const v4, 0x3dcccccd    # 0.1f

    mul-float/2addr v4, p2

    add-float v0, v3, v4

    .line 543
    .local v0, "newTop":F
    iget v3, p0, Landroid/support/design/widget/BottomSheetBehavior;->mMaxOffset:I

    int-to-float v3, v3

    sub-float v3, v0, v3

    invoke-static {v3}, Ljava/lang/Math;->abs(F)F

    move-result v3

    iget v4, p0, Landroid/support/design/widget/BottomSheetBehavior;->mPeekHeight:I

    int-to-float v4, v4

    div-float/2addr v3, v4

    const/high16 v4, 0x3f000000    # 0.5f

    cmpl-float v3, v3, v4

    if-gtz v3, :cond_0

    move v1, v2

    goto :goto_0
.end method


# virtual methods
.method public final getPeekHeight()I
    .locals 1

    .prologue
    .line 411
    .local p0, "this":Landroid/support/design/widget/BottomSheetBehavior;, "Landroid/support/design/widget/BottomSheetBehavior<TV;>;"
    iget v0, p0, Landroid/support/design/widget/BottomSheetBehavior;->mPeekHeight:I

    return v0
.end method

.method public getSkipCollapsed()Z
    .locals 1

    .prologue
    .line 453
    .local p0, "this":Landroid/support/design/widget/BottomSheetBehavior;, "Landroid/support/design/widget/BottomSheetBehavior<TV;>;"
    iget-boolean v0, p0, Landroid/support/design/widget/BottomSheetBehavior;->mSkipCollapsed:Z

    return v0
.end method

.method public final getState()I
    .locals 1

    .prologue
    .line 512
    .local p0, "this":Landroid/support/design/widget/BottomSheetBehavior;, "Landroid/support/design/widget/BottomSheetBehavior<TV;>;"
    iget v0, p0, Landroid/support/design/widget/BottomSheetBehavior;->mState:I

    return v0
.end method

.method public isHideable()Z
    .locals 1

    .prologue
    .line 431
    .local p0, "this":Landroid/support/design/widget/BottomSheetBehavior;, "Landroid/support/design/widget/BottomSheetBehavior<TV;>;"
    iget-boolean v0, p0, Landroid/support/design/widget/BottomSheetBehavior;->mHideable:Z

    return v0
.end method

.method public onInterceptTouchEvent(Landroid/support/design/widget/CoordinatorLayout;Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 7
    .param p1, "parent"    # Landroid/support/design/widget/CoordinatorLayout;
    .param p3, "event"    # Landroid/view/MotionEvent;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/support/design/widget/CoordinatorLayout;",
            "TV;",
            "Landroid/view/MotionEvent;",
            ")Z"
        }
    .end annotation

    .prologue
    .local p0, "this":Landroid/support/design/widget/BottomSheetBehavior;, "Landroid/support/design/widget/BottomSheetBehavior<TV;>;"
    .local p2, "child":Landroid/view/View;, "TV;"
    const/4 v6, -0x1

    const/4 v4, 0x1

    const/4 v5, 0x0

    .line 224
    invoke-virtual {p2}, Landroid/view/View;->isShown()Z

    move-result v3

    if-nez v3, :cond_0

    .line 269
    :goto_0
    return v5

    .line 227
    :cond_0
    invoke-static {p3}, Landroid/support/v4/view/MotionEventCompat;->getActionMasked(Landroid/view/MotionEvent;)I

    move-result v0

    .line 229
    .local v0, "action":I
    if-nez v0, :cond_1

    .line 230
    invoke-direct {p0}, Landroid/support/design/widget/BottomSheetBehavior;->reset()V

    .line 232
    :cond_1
    iget-object v3, p0, Landroid/support/design/widget/BottomSheetBehavior;->mVelocityTracker:Landroid/view/VelocityTracker;

    if-nez v3, :cond_2

    .line 233
    invoke-static {}, Landroid/view/VelocityTracker;->obtain()Landroid/view/VelocityTracker;

    move-result-object v3

    iput-object v3, p0, Landroid/support/design/widget/BottomSheetBehavior;->mVelocityTracker:Landroid/view/VelocityTracker;

    .line 235
    :cond_2
    iget-object v3, p0, Landroid/support/design/widget/BottomSheetBehavior;->mVelocityTracker:Landroid/view/VelocityTracker;

    invoke-virtual {v3, p3}, Landroid/view/VelocityTracker;->addMovement(Landroid/view/MotionEvent;)V

    .line 236
    packed-switch v0, :pswitch_data_0

    .line 259
    :cond_3
    :goto_1
    :pswitch_0
    iget-boolean v3, p0, Landroid/support/design/widget/BottomSheetBehavior;->mIgnoreEvents:Z

    if-nez v3, :cond_6

    iget-object v3, p0, Landroid/support/design/widget/BottomSheetBehavior;->mViewDragHelper:Landroid/support/v4/widget/ViewDragHelper;

    invoke-virtual {v3, p3}, Landroid/support/v4/widget/ViewDragHelper;->shouldInterceptTouchEvent(Landroid/view/MotionEvent;)Z

    move-result v3

    if-eqz v3, :cond_6

    move v5, v4

    .line 260
    goto :goto_0

    .line 239
    :pswitch_1
    iput-boolean v5, p0, Landroid/support/design/widget/BottomSheetBehavior;->mTouchingScrollingChild:Z

    .line 240
    iput v6, p0, Landroid/support/design/widget/BottomSheetBehavior;->mActivePointerId:I

    .line 242
    iget-boolean v3, p0, Landroid/support/design/widget/BottomSheetBehavior;->mIgnoreEvents:Z

    if-eqz v3, :cond_3

    .line 243
    iput-boolean v5, p0, Landroid/support/design/widget/BottomSheetBehavior;->mIgnoreEvents:Z

    goto :goto_0

    .line 248
    :pswitch_2
    invoke-virtual {p3}, Landroid/view/MotionEvent;->getX()F

    move-result v3

    float-to-int v1, v3

    .line 249
    .local v1, "initialX":I
    invoke-virtual {p3}, Landroid/view/MotionEvent;->getY()F

    move-result v3

    float-to-int v3, v3

    iput v3, p0, Landroid/support/design/widget/BottomSheetBehavior;->mInitialY:I

    .line 250
    iget-object v3, p0, Landroid/support/design/widget/BottomSheetBehavior;->mNestedScrollingChildRef:Ljava/lang/ref/WeakReference;

    invoke-virtual {v3}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/view/View;

    .line 251
    .local v2, "scroll":Landroid/view/View;
    if-eqz v2, :cond_4

    iget v3, p0, Landroid/support/design/widget/BottomSheetBehavior;->mInitialY:I

    invoke-virtual {p1, v2, v1, v3}, Landroid/support/design/widget/CoordinatorLayout;->isPointInChildBounds(Landroid/view/View;II)Z

    move-result v3

    if-eqz v3, :cond_4

    .line 252
    invoke-virtual {p3}, Landroid/view/MotionEvent;->getActionIndex()I

    move-result v3

    invoke-virtual {p3, v3}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v3

    iput v3, p0, Landroid/support/design/widget/BottomSheetBehavior;->mActivePointerId:I

    .line 253
    iput-boolean v4, p0, Landroid/support/design/widget/BottomSheetBehavior;->mTouchingScrollingChild:Z

    .line 255
    :cond_4
    iget v3, p0, Landroid/support/design/widget/BottomSheetBehavior;->mActivePointerId:I

    if-ne v3, v6, :cond_5

    iget v3, p0, Landroid/support/design/widget/BottomSheetBehavior;->mInitialY:I

    .line 256
    invoke-virtual {p1, p2, v1, v3}, Landroid/support/design/widget/CoordinatorLayout;->isPointInChildBounds(Landroid/view/View;II)Z

    move-result v3

    if-nez v3, :cond_5

    move v3, v4

    :goto_2
    iput-boolean v3, p0, Landroid/support/design/widget/BottomSheetBehavior;->mIgnoreEvents:Z

    goto :goto_1

    :cond_5
    move v3, v5

    goto :goto_2

    .line 265
    .end local v1    # "initialX":I
    .end local v2    # "scroll":Landroid/view/View;
    :cond_6
    iget-object v3, p0, Landroid/support/design/widget/BottomSheetBehavior;->mNestedScrollingChildRef:Ljava/lang/ref/WeakReference;

    invoke-virtual {v3}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/view/View;

    .line 266
    .restart local v2    # "scroll":Landroid/view/View;
    const/4 v3, 0x2

    if-ne v0, v3, :cond_7

    if-eqz v2, :cond_7

    iget-boolean v3, p0, Landroid/support/design/widget/BottomSheetBehavior;->mIgnoreEvents:Z

    if-nez v3, :cond_7

    iget v3, p0, Landroid/support/design/widget/BottomSheetBehavior;->mState:I

    if-eq v3, v4, :cond_7

    .line 268
    invoke-virtual {p3}, Landroid/view/MotionEvent;->getX()F

    move-result v3

    float-to-int v3, v3

    invoke-virtual {p3}, Landroid/view/MotionEvent;->getY()F

    move-result v6

    float-to-int v6, v6

    invoke-virtual {p1, v2, v3, v6}, Landroid/support/design/widget/CoordinatorLayout;->isPointInChildBounds(Landroid/view/View;II)Z

    move-result v3

    if-nez v3, :cond_7

    iget v3, p0, Landroid/support/design/widget/BottomSheetBehavior;->mInitialY:I

    int-to-float v3, v3

    .line 269
    invoke-virtual {p3}, Landroid/view/MotionEvent;->getY()F

    move-result v6

    sub-float/2addr v3, v6

    invoke-static {v3}, Ljava/lang/Math;->abs(F)F

    move-result v3

    iget-object v6, p0, Landroid/support/design/widget/BottomSheetBehavior;->mViewDragHelper:Landroid/support/v4/widget/ViewDragHelper;

    invoke-virtual {v6}, Landroid/support/v4/widget/ViewDragHelper;->getTouchSlop()I

    move-result v6

    int-to-float v6, v6

    cmpl-float v3, v3, v6

    if-lez v3, :cond_7

    :goto_3
    move v5, v4

    goto/16 :goto_0

    :cond_7
    move v4, v5

    goto :goto_3

    .line 236
    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method public onLayoutChild(Landroid/support/design/widget/CoordinatorLayout;Landroid/view/View;I)Z
    .locals 5
    .param p1, "parent"    # Landroid/support/design/widget/CoordinatorLayout;
    .param p3, "layoutDirection"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/support/design/widget/CoordinatorLayout;",
            "TV;I)Z"
        }
    .end annotation

    .prologue
    .local p0, "this":Landroid/support/design/widget/BottomSheetBehavior;, "Landroid/support/design/widget/BottomSheetBehavior<TV;>;"
    .local p2, "child":Landroid/view/View;, "TV;"
    const/4 v4, 0x1

    .line 195
    invoke-static {p1}, Landroid/support/v4/view/ViewCompat;->getFitsSystemWindows(Landroid/view/View;)Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-static {p2}, Landroid/support/v4/view/ViewCompat;->getFitsSystemWindows(Landroid/view/View;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 196
    invoke-static {p2, v4}, Landroid/support/v4/view/ViewCompat;->setFitsSystemWindows(Landroid/view/View;Z)V

    .line 198
    :cond_0
    invoke-virtual {p2}, Landroid/view/View;->getTop()I

    move-result v0

    .line 200
    .local v0, "savedTop":I
    invoke-virtual {p1, p2, p3}, Landroid/support/design/widget/CoordinatorLayout;->onLayoutChild(Landroid/view/View;I)V

    .line 202
    invoke-virtual {p1}, Landroid/support/design/widget/CoordinatorLayout;->getHeight()I

    move-result v1

    iput v1, p0, Landroid/support/design/widget/BottomSheetBehavior;->mParentHeight:I

    .line 203
    const/4 v1, 0x0

    iget v2, p0, Landroid/support/design/widget/BottomSheetBehavior;->mParentHeight:I

    invoke-virtual {p2}, Landroid/view/View;->getHeight()I

    move-result v3

    sub-int/2addr v2, v3

    invoke-static {v1, v2}, Ljava/lang/Math;->max(II)I

    move-result v1

    iput v1, p0, Landroid/support/design/widget/BottomSheetBehavior;->mMinOffset:I

    .line 204
    iget v1, p0, Landroid/support/design/widget/BottomSheetBehavior;->mParentHeight:I

    iget v2, p0, Landroid/support/design/widget/BottomSheetBehavior;->mPeekHeight:I

    sub-int/2addr v1, v2

    iget v2, p0, Landroid/support/design/widget/BottomSheetBehavior;->mMinOffset:I

    invoke-static {v1, v2}, Ljava/lang/Math;->max(II)I

    move-result v1

    iput v1, p0, Landroid/support/design/widget/BottomSheetBehavior;->mMaxOffset:I

    .line 205
    iget v1, p0, Landroid/support/design/widget/BottomSheetBehavior;->mState:I

    const/4 v2, 0x3

    if-ne v1, v2, :cond_3

    .line 206
    iget v1, p0, Landroid/support/design/widget/BottomSheetBehavior;->mMinOffset:I

    invoke-static {p2, v1}, Landroid/support/v4/view/ViewCompat;->offsetTopAndBottom(Landroid/view/View;I)V

    .line 214
    :cond_1
    :goto_0
    iget-object v1, p0, Landroid/support/design/widget/BottomSheetBehavior;->mViewDragHelper:Landroid/support/v4/widget/ViewDragHelper;

    if-nez v1, :cond_2

    .line 215
    iget-object v1, p0, Landroid/support/design/widget/BottomSheetBehavior;->mDragCallback:Landroid/support/v4/widget/ViewDragHelper$Callback;

    invoke-static {p1, v1}, Landroid/support/v4/widget/ViewDragHelper;->create(Landroid/view/ViewGroup;Landroid/support/v4/widget/ViewDragHelper$Callback;)Landroid/support/v4/widget/ViewDragHelper;

    move-result-object v1

    iput-object v1, p0, Landroid/support/design/widget/BottomSheetBehavior;->mViewDragHelper:Landroid/support/v4/widget/ViewDragHelper;

    .line 217
    :cond_2
    new-instance v1, Ljava/lang/ref/WeakReference;

    invoke-direct {v1, p2}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v1, p0, Landroid/support/design/widget/BottomSheetBehavior;->mViewRef:Ljava/lang/ref/WeakReference;

    .line 218
    new-instance v1, Ljava/lang/ref/WeakReference;

    invoke-direct {p0, p2}, Landroid/support/design/widget/BottomSheetBehavior;->findScrollingChild(Landroid/view/View;)Landroid/view/View;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v1, p0, Landroid/support/design/widget/BottomSheetBehavior;->mNestedScrollingChildRef:Ljava/lang/ref/WeakReference;

    .line 219
    return v4

    .line 207
    :cond_3
    iget-boolean v1, p0, Landroid/support/design/widget/BottomSheetBehavior;->mHideable:Z

    if-eqz v1, :cond_4

    iget v1, p0, Landroid/support/design/widget/BottomSheetBehavior;->mState:I

    const/4 v2, 0x5

    if-ne v1, v2, :cond_4

    .line 208
    iget v1, p0, Landroid/support/design/widget/BottomSheetBehavior;->mParentHeight:I

    invoke-static {p2, v1}, Landroid/support/v4/view/ViewCompat;->offsetTopAndBottom(Landroid/view/View;I)V

    goto :goto_0

    .line 209
    :cond_4
    iget v1, p0, Landroid/support/design/widget/BottomSheetBehavior;->mState:I

    const/4 v2, 0x4

    if-ne v1, v2, :cond_5

    .line 210
    iget v1, p0, Landroid/support/design/widget/BottomSheetBehavior;->mMaxOffset:I

    invoke-static {p2, v1}, Landroid/support/v4/view/ViewCompat;->offsetTopAndBottom(Landroid/view/View;I)V

    goto :goto_0

    .line 211
    :cond_5
    iget v1, p0, Landroid/support/design/widget/BottomSheetBehavior;->mState:I

    if-eq v1, v4, :cond_6

    iget v1, p0, Landroid/support/design/widget/BottomSheetBehavior;->mState:I

    const/4 v2, 0x2

    if-ne v1, v2, :cond_1

    .line 212
    :cond_6
    invoke-virtual {p2}, Landroid/view/View;->getTop()I

    move-result v1

    sub-int v1, v0, v1

    invoke-static {p2, v1}, Landroid/support/v4/view/ViewCompat;->offsetTopAndBottom(Landroid/view/View;I)V

    goto :goto_0
.end method

.method public onNestedPreFling(Landroid/support/design/widget/CoordinatorLayout;Landroid/view/View;Landroid/view/View;FF)Z
    .locals 2
    .param p1, "coordinatorLayout"    # Landroid/support/design/widget/CoordinatorLayout;
    .param p3, "target"    # Landroid/view/View;
    .param p4, "velocityX"    # F
    .param p5, "velocityY"    # F
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/support/design/widget/CoordinatorLayout;",
            "TV;",
            "Landroid/view/View;",
            "FF)Z"
        }
    .end annotation

    .prologue
    .line 387
    .local p0, "this":Landroid/support/design/widget/BottomSheetBehavior;, "Landroid/support/design/widget/BottomSheetBehavior<TV;>;"
    .local p2, "child":Landroid/view/View;, "TV;"
    iget-object v0, p0, Landroid/support/design/widget/BottomSheetBehavior;->mNestedScrollingChildRef:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    if-ne p3, v0, :cond_1

    iget v0, p0, Landroid/support/design/widget/BottomSheetBehavior;->mState:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_0

    .line 389
    invoke-super/range {p0 .. p5}, Landroid/support/design/widget/CoordinatorLayout$Behavior;->onNestedPreFling(Landroid/support/design/widget/CoordinatorLayout;Landroid/view/View;Landroid/view/View;FF)Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public onNestedPreScroll(Landroid/support/design/widget/CoordinatorLayout;Landroid/view/View;Landroid/view/View;II[I)V
    .locals 5
    .param p1, "coordinatorLayout"    # Landroid/support/design/widget/CoordinatorLayout;
    .param p3, "target"    # Landroid/view/View;
    .param p4, "dx"    # I
    .param p5, "dy"    # I
    .param p6, "consumed"    # [I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/support/design/widget/CoordinatorLayout;",
            "TV;",
            "Landroid/view/View;",
            "II[I)V"
        }
    .end annotation

    .prologue
    .local p0, "this":Landroid/support/design/widget/BottomSheetBehavior;, "Landroid/support/design/widget/BottomSheetBehavior<TV;>;"
    .local p2, "child":Landroid/view/View;, "TV;"
    const/4 v4, 0x1

    .line 311
    iget-object v3, p0, Landroid/support/design/widget/BottomSheetBehavior;->mNestedScrollingChildRef:Ljava/lang/ref/WeakReference;

    invoke-virtual {v3}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/view/View;

    .line 312
    .local v2, "scrollingChild":Landroid/view/View;
    if-eq p3, v2, :cond_0

    .line 343
    :goto_0
    return-void

    .line 315
    :cond_0
    invoke-virtual {p2}, Landroid/view/View;->getTop()I

    move-result v0

    .line 316
    .local v0, "currentTop":I
    sub-int v1, v0, p5

    .line 317
    .local v1, "newTop":I
    if-lez p5, :cond_3

    .line 318
    iget v3, p0, Landroid/support/design/widget/BottomSheetBehavior;->mMinOffset:I

    if-ge v1, v3, :cond_2

    .line 319
    iget v3, p0, Landroid/support/design/widget/BottomSheetBehavior;->mMinOffset:I

    sub-int v3, v0, v3

    aput v3, p6, v4

    .line 320
    aget v3, p6, v4

    neg-int v3, v3

    invoke-static {p2, v3}, Landroid/support/v4/view/ViewCompat;->offsetTopAndBottom(Landroid/view/View;I)V

    .line 321
    const/4 v3, 0x3

    invoke-direct {p0, v3}, Landroid/support/design/widget/BottomSheetBehavior;->setStateInternal(I)V

    .line 340
    :cond_1
    :goto_1
    invoke-virtual {p2}, Landroid/view/View;->getTop()I

    move-result v3

    invoke-direct {p0, v3}, Landroid/support/design/widget/BottomSheetBehavior;->dispatchOnSlide(I)V

    .line 341
    iput p5, p0, Landroid/support/design/widget/BottomSheetBehavior;->mLastNestedScrollDy:I

    .line 342
    iput-boolean v4, p0, Landroid/support/design/widget/BottomSheetBehavior;->mNestedScrolled:Z

    goto :goto_0

    .line 323
    :cond_2
    aput p5, p6, v4

    .line 324
    neg-int v3, p5

    invoke-static {p2, v3}, Landroid/support/v4/view/ViewCompat;->offsetTopAndBottom(Landroid/view/View;I)V

    .line 325
    invoke-direct {p0, v4}, Landroid/support/design/widget/BottomSheetBehavior;->setStateInternal(I)V

    goto :goto_1

    .line 327
    :cond_3
    if-gez p5, :cond_1

    .line 328
    const/4 v3, -0x1

    invoke-static {p3, v3}, Landroid/support/v4/view/ViewCompat;->canScrollVertically(Landroid/view/View;I)Z

    move-result v3

    if-nez v3, :cond_1

    .line 329
    iget v3, p0, Landroid/support/design/widget/BottomSheetBehavior;->mMaxOffset:I

    if-le v1, v3, :cond_4

    iget-boolean v3, p0, Landroid/support/design/widget/BottomSheetBehavior;->mHideable:Z

    if-eqz v3, :cond_5

    .line 330
    :cond_4
    aput p5, p6, v4

    .line 331
    neg-int v3, p5

    invoke-static {p2, v3}, Landroid/support/v4/view/ViewCompat;->offsetTopAndBottom(Landroid/view/View;I)V

    .line 332
    invoke-direct {p0, v4}, Landroid/support/design/widget/BottomSheetBehavior;->setStateInternal(I)V

    goto :goto_1

    .line 334
    :cond_5
    iget v3, p0, Landroid/support/design/widget/BottomSheetBehavior;->mMaxOffset:I

    sub-int v3, v0, v3

    aput v3, p6, v4

    .line 335
    aget v3, p6, v4

    neg-int v3, v3

    invoke-static {p2, v3}, Landroid/support/v4/view/ViewCompat;->offsetTopAndBottom(Landroid/view/View;I)V

    .line 336
    const/4 v3, 0x4

    invoke-direct {p0, v3}, Landroid/support/design/widget/BottomSheetBehavior;->setStateInternal(I)V

    goto :goto_1
.end method

.method public onRestoreInstanceState(Landroid/support/design/widget/CoordinatorLayout;Landroid/view/View;Landroid/os/Parcelable;)V
    .locals 3
    .param p1, "parent"    # Landroid/support/design/widget/CoordinatorLayout;
    .param p3, "state"    # Landroid/os/Parcelable;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/support/design/widget/CoordinatorLayout;",
            "TV;",
            "Landroid/os/Parcelable;",
            ")V"
        }
    .end annotation

    .prologue
    .line 183
    .local p0, "this":Landroid/support/design/widget/BottomSheetBehavior;, "Landroid/support/design/widget/BottomSheetBehavior<TV;>;"
    .local p2, "child":Landroid/view/View;, "TV;"
    move-object v0, p3

    check-cast v0, Landroid/support/design/widget/BottomSheetBehavior$SavedState;

    .line 184
    .local v0, "ss":Landroid/support/design/widget/BottomSheetBehavior$SavedState;
    invoke-virtual {v0}, Landroid/support/design/widget/BottomSheetBehavior$SavedState;->getSuperState()Landroid/os/Parcelable;

    move-result-object v1

    invoke-super {p0, p1, p2, v1}, Landroid/support/design/widget/CoordinatorLayout$Behavior;->onRestoreInstanceState(Landroid/support/design/widget/CoordinatorLayout;Landroid/view/View;Landroid/os/Parcelable;)V

    .line 186
    iget v1, v0, Landroid/support/design/widget/BottomSheetBehavior$SavedState;->state:I

    const/4 v2, 0x1

    if-eq v1, v2, :cond_0

    iget v1, v0, Landroid/support/design/widget/BottomSheetBehavior$SavedState;->state:I

    const/4 v2, 0x2

    if-ne v1, v2, :cond_1

    .line 187
    :cond_0
    const/4 v1, 0x4

    iput v1, p0, Landroid/support/design/widget/BottomSheetBehavior;->mState:I

    .line 191
    :goto_0
    return-void

    .line 189
    :cond_1
    iget v1, v0, Landroid/support/design/widget/BottomSheetBehavior$SavedState;->state:I

    iput v1, p0, Landroid/support/design/widget/BottomSheetBehavior;->mState:I

    goto :goto_0
.end method

.method public onSaveInstanceState(Landroid/support/design/widget/CoordinatorLayout;Landroid/view/View;)Landroid/os/Parcelable;
    .locals 3
    .param p1, "parent"    # Landroid/support/design/widget/CoordinatorLayout;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/support/design/widget/CoordinatorLayout;",
            "TV;)",
            "Landroid/os/Parcelable;"
        }
    .end annotation

    .prologue
    .line 178
    .local p0, "this":Landroid/support/design/widget/BottomSheetBehavior;, "Landroid/support/design/widget/BottomSheetBehavior<TV;>;"
    .local p2, "child":Landroid/view/View;, "TV;"
    new-instance v0, Landroid/support/design/widget/BottomSheetBehavior$SavedState;

    invoke-super {p0, p1, p2}, Landroid/support/design/widget/CoordinatorLayout$Behavior;->onSaveInstanceState(Landroid/support/design/widget/CoordinatorLayout;Landroid/view/View;)Landroid/os/Parcelable;

    move-result-object v1

    iget v2, p0, Landroid/support/design/widget/BottomSheetBehavior;->mState:I

    invoke-direct {v0, v1, v2}, Landroid/support/design/widget/BottomSheetBehavior$SavedState;-><init>(Landroid/os/Parcelable;I)V

    return-object v0
.end method

.method public onStartNestedScroll(Landroid/support/design/widget/CoordinatorLayout;Landroid/view/View;Landroid/view/View;Landroid/view/View;I)Z
    .locals 2
    .param p1, "coordinatorLayout"    # Landroid/support/design/widget/CoordinatorLayout;
    .param p3, "directTargetChild"    # Landroid/view/View;
    .param p4, "target"    # Landroid/view/View;
    .param p5, "nestedScrollAxes"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/support/design/widget/CoordinatorLayout;",
            "TV;",
            "Landroid/view/View;",
            "Landroid/view/View;",
            "I)Z"
        }
    .end annotation

    .prologue
    .local p0, "this":Landroid/support/design/widget/BottomSheetBehavior;, "Landroid/support/design/widget/BottomSheetBehavior<TV;>;"
    .local p2, "child":Landroid/view/View;, "TV;"
    const/4 v0, 0x0

    .line 303
    iput v0, p0, Landroid/support/design/widget/BottomSheetBehavior;->mLastNestedScrollDy:I

    .line 304
    iput-boolean v0, p0, Landroid/support/design/widget/BottomSheetBehavior;->mNestedScrolled:Z

    .line 305
    and-int/lit8 v1, p5, 0x2

    if-eqz v1, :cond_0

    const/4 v0, 0x1

    :cond_0
    return v0
.end method

.method public onStopNestedScroll(Landroid/support/design/widget/CoordinatorLayout;Landroid/view/View;Landroid/view/View;)V
    .locals 5
    .param p1, "coordinatorLayout"    # Landroid/support/design/widget/CoordinatorLayout;
    .param p3, "target"    # Landroid/view/View;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/support/design/widget/CoordinatorLayout;",
            "TV;",
            "Landroid/view/View;",
            ")V"
        }
    .end annotation

    .prologue
    .line 347
    .local p0, "this":Landroid/support/design/widget/BottomSheetBehavior;, "Landroid/support/design/widget/BottomSheetBehavior<TV;>;"
    .local p2, "child":Landroid/view/View;, "TV;"
    invoke-virtual {p2}, Landroid/view/View;->getTop()I

    move-result v3

    iget v4, p0, Landroid/support/design/widget/BottomSheetBehavior;->mMinOffset:I

    if-ne v3, v4, :cond_1

    .line 348
    const/4 v3, 0x3

    invoke-direct {p0, v3}, Landroid/support/design/widget/BottomSheetBehavior;->setStateInternal(I)V

    .line 382
    :cond_0
    :goto_0
    return-void

    .line 351
    :cond_1
    iget-object v3, p0, Landroid/support/design/widget/BottomSheetBehavior;->mNestedScrollingChildRef:Ljava/lang/ref/WeakReference;

    invoke-virtual {v3}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v3

    if-ne p3, v3, :cond_0

    iget-boolean v3, p0, Landroid/support/design/widget/BottomSheetBehavior;->mNestedScrolled:Z

    if-eqz v3, :cond_0

    .line 356
    iget v3, p0, Landroid/support/design/widget/BottomSheetBehavior;->mLastNestedScrollDy:I

    if-lez v3, :cond_2

    .line 357
    iget v2, p0, Landroid/support/design/widget/BottomSheetBehavior;->mMinOffset:I

    .line 358
    .local v2, "top":I
    const/4 v1, 0x3

    .line 375
    .local v1, "targetState":I
    :goto_1
    iget-object v3, p0, Landroid/support/design/widget/BottomSheetBehavior;->mViewDragHelper:Landroid/support/v4/widget/ViewDragHelper;

    invoke-virtual {p2}, Landroid/view/View;->getLeft()I

    move-result v4

    invoke-virtual {v3, p2, v4, v2}, Landroid/support/v4/widget/ViewDragHelper;->smoothSlideViewTo(Landroid/view/View;II)Z

    move-result v3

    if-eqz v3, :cond_6

    .line 376
    const/4 v3, 0x2

    invoke-direct {p0, v3}, Landroid/support/design/widget/BottomSheetBehavior;->setStateInternal(I)V

    .line 377
    new-instance v3, Landroid/support/design/widget/BottomSheetBehavior$SettleRunnable;

    invoke-direct {v3, p0, p2, v1}, Landroid/support/design/widget/BottomSheetBehavior$SettleRunnable;-><init>(Landroid/support/design/widget/BottomSheetBehavior;Landroid/view/View;I)V

    invoke-static {p2, v3}, Landroid/support/v4/view/ViewCompat;->postOnAnimation(Landroid/view/View;Ljava/lang/Runnable;)V

    .line 381
    :goto_2
    const/4 v3, 0x0

    iput-boolean v3, p0, Landroid/support/design/widget/BottomSheetBehavior;->mNestedScrolled:Z

    goto :goto_0

    .line 359
    .end local v1    # "targetState":I
    .end local v2    # "top":I
    :cond_2
    iget-boolean v3, p0, Landroid/support/design/widget/BottomSheetBehavior;->mHideable:Z

    if-eqz v3, :cond_3

    invoke-direct {p0}, Landroid/support/design/widget/BottomSheetBehavior;->getYVelocity()F

    move-result v3

    invoke-direct {p0, p2, v3}, Landroid/support/design/widget/BottomSheetBehavior;->shouldHide(Landroid/view/View;F)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 360
    iget v2, p0, Landroid/support/design/widget/BottomSheetBehavior;->mParentHeight:I

    .line 361
    .restart local v2    # "top":I
    const/4 v1, 0x5

    .restart local v1    # "targetState":I
    goto :goto_1

    .line 362
    .end local v1    # "targetState":I
    .end local v2    # "top":I
    :cond_3
    iget v3, p0, Landroid/support/design/widget/BottomSheetBehavior;->mLastNestedScrollDy:I

    if-nez v3, :cond_5

    .line 363
    invoke-virtual {p2}, Landroid/view/View;->getTop()I

    move-result v0

    .line 364
    .local v0, "currentTop":I
    iget v3, p0, Landroid/support/design/widget/BottomSheetBehavior;->mMinOffset:I

    sub-int v3, v0, v3

    invoke-static {v3}, Ljava/lang/Math;->abs(I)I

    move-result v3

    iget v4, p0, Landroid/support/design/widget/BottomSheetBehavior;->mMaxOffset:I

    sub-int v4, v0, v4

    invoke-static {v4}, Ljava/lang/Math;->abs(I)I

    move-result v4

    if-ge v3, v4, :cond_4

    .line 365
    iget v2, p0, Landroid/support/design/widget/BottomSheetBehavior;->mMinOffset:I

    .line 366
    .restart local v2    # "top":I
    const/4 v1, 0x3

    .restart local v1    # "targetState":I
    goto :goto_1

    .line 368
    .end local v1    # "targetState":I
    .end local v2    # "top":I
    :cond_4
    iget v2, p0, Landroid/support/design/widget/BottomSheetBehavior;->mMaxOffset:I

    .line 369
    .restart local v2    # "top":I
    const/4 v1, 0x4

    .restart local v1    # "targetState":I
    goto :goto_1

    .line 372
    .end local v0    # "currentTop":I
    .end local v1    # "targetState":I
    .end local v2    # "top":I
    :cond_5
    iget v2, p0, Landroid/support/design/widget/BottomSheetBehavior;->mMaxOffset:I

    .line 373
    .restart local v2    # "top":I
    const/4 v1, 0x4

    .restart local v1    # "targetState":I
    goto :goto_1

    .line 379
    :cond_6
    invoke-direct {p0, v1}, Landroid/support/design/widget/BottomSheetBehavior;->setStateInternal(I)V

    goto :goto_2
.end method

.method public onTouchEvent(Landroid/support/design/widget/CoordinatorLayout;Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 5
    .param p1, "parent"    # Landroid/support/design/widget/CoordinatorLayout;
    .param p3, "event"    # Landroid/view/MotionEvent;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/support/design/widget/CoordinatorLayout;",
            "TV;",
            "Landroid/view/MotionEvent;",
            ")Z"
        }
    .end annotation

    .prologue
    .local p0, "this":Landroid/support/design/widget/BottomSheetBehavior;, "Landroid/support/design/widget/BottomSheetBehavior<TV;>;"
    .local p2, "child":Landroid/view/View;, "TV;"
    const/4 v2, 0x0

    const/4 v1, 0x1

    .line 274
    invoke-virtual {p2}, Landroid/view/View;->isShown()Z

    move-result v3

    if-nez v3, :cond_1

    move v1, v2

    .line 297
    :cond_0
    :goto_0
    return v1

    .line 277
    :cond_1
    invoke-static {p3}, Landroid/support/v4/view/MotionEventCompat;->getActionMasked(Landroid/view/MotionEvent;)I

    move-result v0

    .line 278
    .local v0, "action":I
    iget v3, p0, Landroid/support/design/widget/BottomSheetBehavior;->mState:I

    if-ne v3, v1, :cond_2

    if-eqz v0, :cond_0

    .line 281
    :cond_2
    iget-object v3, p0, Landroid/support/design/widget/BottomSheetBehavior;->mViewDragHelper:Landroid/support/v4/widget/ViewDragHelper;

    invoke-virtual {v3, p3}, Landroid/support/v4/widget/ViewDragHelper;->processTouchEvent(Landroid/view/MotionEvent;)V

    .line 283
    if-nez v0, :cond_3

    .line 284
    invoke-direct {p0}, Landroid/support/design/widget/BottomSheetBehavior;->reset()V

    .line 286
    :cond_3
    iget-object v3, p0, Landroid/support/design/widget/BottomSheetBehavior;->mVelocityTracker:Landroid/view/VelocityTracker;

    if-nez v3, :cond_4

    .line 287
    invoke-static {}, Landroid/view/VelocityTracker;->obtain()Landroid/view/VelocityTracker;

    move-result-object v3

    iput-object v3, p0, Landroid/support/design/widget/BottomSheetBehavior;->mVelocityTracker:Landroid/view/VelocityTracker;

    .line 289
    :cond_4
    iget-object v3, p0, Landroid/support/design/widget/BottomSheetBehavior;->mVelocityTracker:Landroid/view/VelocityTracker;

    invoke-virtual {v3, p3}, Landroid/view/VelocityTracker;->addMovement(Landroid/view/MotionEvent;)V

    .line 292
    const/4 v3, 0x2

    if-ne v0, v3, :cond_5

    iget-boolean v3, p0, Landroid/support/design/widget/BottomSheetBehavior;->mIgnoreEvents:Z

    if-nez v3, :cond_5

    .line 293
    iget v3, p0, Landroid/support/design/widget/BottomSheetBehavior;->mInitialY:I

    int-to-float v3, v3

    invoke-virtual {p3}, Landroid/view/MotionEvent;->getY()F

    move-result v4

    sub-float/2addr v3, v4

    invoke-static {v3}, Ljava/lang/Math;->abs(F)F

    move-result v3

    iget-object v4, p0, Landroid/support/design/widget/BottomSheetBehavior;->mViewDragHelper:Landroid/support/v4/widget/ViewDragHelper;

    invoke-virtual {v4}, Landroid/support/v4/widget/ViewDragHelper;->getTouchSlop()I

    move-result v4

    int-to-float v4, v4

    cmpl-float v3, v3, v4

    if-lez v3, :cond_5

    .line 294
    iget-object v3, p0, Landroid/support/design/widget/BottomSheetBehavior;->mViewDragHelper:Landroid/support/v4/widget/ViewDragHelper;

    invoke-virtual {p3}, Landroid/view/MotionEvent;->getActionIndex()I

    move-result v4

    invoke-virtual {p3, v4}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v4

    invoke-virtual {v3, p2, v4}, Landroid/support/v4/widget/ViewDragHelper;->captureChildView(Landroid/view/View;I)V

    .line 297
    :cond_5
    iget-boolean v3, p0, Landroid/support/design/widget/BottomSheetBehavior;->mIgnoreEvents:Z

    if-eqz v3, :cond_0

    move v1, v2

    goto :goto_0
.end method

.method public setBottomSheetCallback(Landroid/support/design/widget/BottomSheetBehavior$BottomSheetCallback;)V
    .locals 0
    .param p1, "callback"    # Landroid/support/design/widget/BottomSheetBehavior$BottomSheetCallback;

    .prologue
    .line 462
    .local p0, "this":Landroid/support/design/widget/BottomSheetBehavior;, "Landroid/support/design/widget/BottomSheetBehavior<TV;>;"
    iput-object p1, p0, Landroid/support/design/widget/BottomSheetBehavior;->mCallback:Landroid/support/design/widget/BottomSheetBehavior$BottomSheetCallback;

    .line 463
    return-void
.end method

.method public setHideable(Z)V
    .locals 0
    .param p1, "hideable"    # Z

    .prologue
    .line 421
    .local p0, "this":Landroid/support/design/widget/BottomSheetBehavior;, "Landroid/support/design/widget/BottomSheetBehavior<TV;>;"
    iput-boolean p1, p0, Landroid/support/design/widget/BottomSheetBehavior;->mHideable:Z

    .line 422
    return-void
.end method

.method public final setPeekHeight(I)V
    .locals 1
    .param p1, "peekHeight"    # I

    .prologue
    .line 400
    .local p0, "this":Landroid/support/design/widget/BottomSheetBehavior;, "Landroid/support/design/widget/BottomSheetBehavior<TV;>;"
    const/4 v0, 0x0

    invoke-static {v0, p1}, Ljava/lang/Math;->max(II)I

    move-result v0

    iput v0, p0, Landroid/support/design/widget/BottomSheetBehavior;->mPeekHeight:I

    .line 401
    iget v0, p0, Landroid/support/design/widget/BottomSheetBehavior;->mParentHeight:I

    sub-int/2addr v0, p1

    iput v0, p0, Landroid/support/design/widget/BottomSheetBehavior;->mMaxOffset:I

    .line 402
    return-void
.end method

.method public setSkipCollapsed(Z)V
    .locals 0
    .param p1, "skipCollapsed"    # Z

    .prologue
    .line 442
    .local p0, "this":Landroid/support/design/widget/BottomSheetBehavior;, "Landroid/support/design/widget/BottomSheetBehavior<TV;>;"
    iput-boolean p1, p0, Landroid/support/design/widget/BottomSheetBehavior;->mSkipCollapsed:Z

    .line 443
    return-void
.end method

.method public final setState(I)V
    .locals 6
    .param p1, "state"    # I

    .prologue
    .local p0, "this":Landroid/support/design/widget/BottomSheetBehavior;, "Landroid/support/design/widget/BottomSheetBehavior<TV;>;"
    const/4 v5, 0x5

    const/4 v4, 0x4

    const/4 v3, 0x3

    .line 473
    iget v2, p0, Landroid/support/design/widget/BottomSheetBehavior;->mState:I

    if-ne p1, v2, :cond_1

    .line 502
    :cond_0
    :goto_0
    return-void

    .line 476
    :cond_1
    iget-object v2, p0, Landroid/support/design/widget/BottomSheetBehavior;->mViewRef:Ljava/lang/ref/WeakReference;

    if-nez v2, :cond_3

    .line 478
    if-eq p1, v4, :cond_2

    if-eq p1, v3, :cond_2

    iget-boolean v2, p0, Landroid/support/design/widget/BottomSheetBehavior;->mHideable:Z

    if-eqz v2, :cond_0

    if-ne p1, v5, :cond_0

    .line 480
    :cond_2
    iput p1, p0, Landroid/support/design/widget/BottomSheetBehavior;->mState:I

    goto :goto_0

    .line 484
    :cond_3
    iget-object v2, p0, Landroid/support/design/widget/BottomSheetBehavior;->mViewRef:Ljava/lang/ref/WeakReference;

    invoke-virtual {v2}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    .line 485
    .local v0, "child":Landroid/view/View;, "TV;"
    if-eqz v0, :cond_0

    .line 489
    if-ne p1, v4, :cond_4

    .line 490
    iget v1, p0, Landroid/support/design/widget/BottomSheetBehavior;->mMaxOffset:I

    .line 498
    .local v1, "top":I
    :goto_1
    const/4 v2, 0x2

    invoke-direct {p0, v2}, Landroid/support/design/widget/BottomSheetBehavior;->setStateInternal(I)V

    .line 499
    iget-object v2, p0, Landroid/support/design/widget/BottomSheetBehavior;->mViewDragHelper:Landroid/support/v4/widget/ViewDragHelper;

    invoke-virtual {v0}, Landroid/view/View;->getLeft()I

    move-result v3

    invoke-virtual {v2, v0, v3, v1}, Landroid/support/v4/widget/ViewDragHelper;->smoothSlideViewTo(Landroid/view/View;II)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 500
    new-instance v2, Landroid/support/design/widget/BottomSheetBehavior$SettleRunnable;

    invoke-direct {v2, p0, v0, p1}, Landroid/support/design/widget/BottomSheetBehavior$SettleRunnable;-><init>(Landroid/support/design/widget/BottomSheetBehavior;Landroid/view/View;I)V

    invoke-static {v0, v2}, Landroid/support/v4/view/ViewCompat;->postOnAnimation(Landroid/view/View;Ljava/lang/Runnable;)V

    goto :goto_0

    .line 491
    .end local v1    # "top":I
    :cond_4
    if-ne p1, v3, :cond_5

    .line 492
    iget v1, p0, Landroid/support/design/widget/BottomSheetBehavior;->mMinOffset:I

    .restart local v1    # "top":I
    goto :goto_1

    .line 493
    .end local v1    # "top":I
    :cond_5
    iget-boolean v2, p0, Landroid/support/design/widget/BottomSheetBehavior;->mHideable:Z

    if-eqz v2, :cond_6

    if-ne p1, v5, :cond_6

    .line 494
    iget v1, p0, Landroid/support/design/widget/BottomSheetBehavior;->mParentHeight:I

    .restart local v1    # "top":I
    goto :goto_1

    .line 496
    .end local v1    # "top":I
    :cond_6
    new-instance v2, Ljava/lang/IllegalArgumentException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Illegal state argument: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v2
.end method
