.class public Landroid/support/test/internal/runner/RunnerArgs;
.super Ljava/lang/Object;
.source "RunnerArgs.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroid/support/test/internal/runner/RunnerArgs$1;,
        Landroid/support/test/internal/runner/RunnerArgs$Builder;,
        Landroid/support/test/internal/runner/RunnerArgs$TestArg;
    }
.end annotation


# static fields
.field static final ARGUMENT_ANNOTATION:Ljava/lang/String; = "annotation"

.field static final ARGUMENT_APP_LISTENER:Ljava/lang/String; = "appListener"

.field static final ARGUMENT_COVERAGE:Ljava/lang/String; = "coverage"

.field static final ARGUMENT_COVERAGE_PATH:Ljava/lang/String; = "coverageFile"

.field static final ARGUMENT_DEBUG:Ljava/lang/String; = "debug"

.field static final ARGUMENT_DELAY_IN_MILLIS:Ljava/lang/String; = "delay_msec"

.field static final ARGUMENT_DISABLE_ANALYTICS:Ljava/lang/String; = "disableAnalytics"

.field static final ARGUMENT_IDLE:Ljava/lang/String; = "idle"

.field static final ARGUMENT_LISTENER:Ljava/lang/String; = "listener"

.field static final ARGUMENT_LOG_ONLY:Ljava/lang/String; = "log"

.field static final ARGUMENT_NOT_ANNOTATION:Ljava/lang/String; = "notAnnotation"

.field static final ARGUMENT_NOT_TEST_CLASS:Ljava/lang/String; = "notClass"

.field static final ARGUMENT_NOT_TEST_PACKAGE:Ljava/lang/String; = "notPackage"

.field static final ARGUMENT_NUM_SHARDS:Ljava/lang/String; = "numShards"

.field static final ARGUMENT_SHARD_INDEX:Ljava/lang/String; = "shardIndex"

.field static final ARGUMENT_SUITE_ASSIGNMENT:Ljava/lang/String; = "suiteAssignment"

.field static final ARGUMENT_TEST_CLASS:Ljava/lang/String; = "class"

.field static final ARGUMENT_TEST_FILE:Ljava/lang/String; = "testFile"

.field static final ARGUMENT_TEST_PACKAGE:Ljava/lang/String; = "package"

.field static final ARGUMENT_TEST_SIZE:Ljava/lang/String; = "size"

.field static final ARGUMENT_TIMEOUT:Ljava/lang/String; = "timeout_msec"

.field private static final CLASS_SEPARATOR:C = ','

.field private static final LOG_TAG:Ljava/lang/String; = "RunnerArgs"

.field private static final METHOD_SEPARATOR:C = '#'


# instance fields
.field public final annotation:Ljava/lang/String;

.field public final appListeners:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Landroid/support/test/runner/lifecycle/ApplicationLifecycleCallback;",
            ">;"
        }
    .end annotation
.end field

.field public final codeCoverage:Z

.field public final codeCoveragePath:Ljava/lang/String;

.field public final debug:Z

.field public final delayInMillis:I

.field public final disableAnalytics:Z

.field public final idle:Z

.field public final listeners:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lorg/junit/runner/notification/RunListener;",
            ">;"
        }
    .end annotation
.end field

.field public final logOnly:Z

.field public final notAnnotations:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field public final notTestPackages:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field public final notTests:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Landroid/support/test/internal/runner/RunnerArgs$TestArg;",
            ">;"
        }
    .end annotation
.end field

.field public final numShards:I

.field public final shardIndex:I

.field public final suiteAssignment:Z

.field public final testPackages:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field public final testSize:Ljava/lang/String;

.field public final testTimeout:J

.field public final tests:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Landroid/support/test/internal/runner/RunnerArgs$TestArg;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method private constructor <init>(Landroid/support/test/internal/runner/RunnerArgs$Builder;)V
    .locals 2
    .param p1, "builder"    # Landroid/support/test/internal/runner/RunnerArgs$Builder;

    .prologue
    .line 94
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 95
    # getter for: Landroid/support/test/internal/runner/RunnerArgs$Builder;->debug:Z
    invoke-static {p1}, Landroid/support/test/internal/runner/RunnerArgs$Builder;->access$000(Landroid/support/test/internal/runner/RunnerArgs$Builder;)Z

    move-result v0

    iput-boolean v0, p0, Landroid/support/test/internal/runner/RunnerArgs;->debug:Z

    .line 96
    # getter for: Landroid/support/test/internal/runner/RunnerArgs$Builder;->suiteAssignment:Z
    invoke-static {p1}, Landroid/support/test/internal/runner/RunnerArgs$Builder;->access$100(Landroid/support/test/internal/runner/RunnerArgs$Builder;)Z

    move-result v0

    iput-boolean v0, p0, Landroid/support/test/internal/runner/RunnerArgs;->suiteAssignment:Z

    .line 97
    # getter for: Landroid/support/test/internal/runner/RunnerArgs$Builder;->codeCoverage:Z
    invoke-static {p1}, Landroid/support/test/internal/runner/RunnerArgs$Builder;->access$200(Landroid/support/test/internal/runner/RunnerArgs$Builder;)Z

    move-result v0

    iput-boolean v0, p0, Landroid/support/test/internal/runner/RunnerArgs;->codeCoverage:Z

    .line 98
    # getter for: Landroid/support/test/internal/runner/RunnerArgs$Builder;->codeCoveragePath:Ljava/lang/String;
    invoke-static {p1}, Landroid/support/test/internal/runner/RunnerArgs$Builder;->access$300(Landroid/support/test/internal/runner/RunnerArgs$Builder;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Landroid/support/test/internal/runner/RunnerArgs;->codeCoveragePath:Ljava/lang/String;

    .line 99
    # getter for: Landroid/support/test/internal/runner/RunnerArgs$Builder;->delayInMillis:I
    invoke-static {p1}, Landroid/support/test/internal/runner/RunnerArgs$Builder;->access$400(Landroid/support/test/internal/runner/RunnerArgs$Builder;)I

    move-result v0

    iput v0, p0, Landroid/support/test/internal/runner/RunnerArgs;->delayInMillis:I

    .line 100
    # getter for: Landroid/support/test/internal/runner/RunnerArgs$Builder;->logOnly:Z
    invoke-static {p1}, Landroid/support/test/internal/runner/RunnerArgs$Builder;->access$500(Landroid/support/test/internal/runner/RunnerArgs$Builder;)Z

    move-result v0

    iput-boolean v0, p0, Landroid/support/test/internal/runner/RunnerArgs;->logOnly:Z

    .line 101
    # getter for: Landroid/support/test/internal/runner/RunnerArgs$Builder;->testPackages:Ljava/util/List;
    invoke-static {p1}, Landroid/support/test/internal/runner/RunnerArgs$Builder;->access$600(Landroid/support/test/internal/runner/RunnerArgs$Builder;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Landroid/support/test/internal/runner/RunnerArgs;->testPackages:Ljava/util/List;

    .line 102
    # getter for: Landroid/support/test/internal/runner/RunnerArgs$Builder;->notTestPackages:Ljava/util/List;
    invoke-static {p1}, Landroid/support/test/internal/runner/RunnerArgs$Builder;->access$700(Landroid/support/test/internal/runner/RunnerArgs$Builder;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Landroid/support/test/internal/runner/RunnerArgs;->notTestPackages:Ljava/util/List;

    .line 103
    # getter for: Landroid/support/test/internal/runner/RunnerArgs$Builder;->testSize:Ljava/lang/String;
    invoke-static {p1}, Landroid/support/test/internal/runner/RunnerArgs$Builder;->access$800(Landroid/support/test/internal/runner/RunnerArgs$Builder;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Landroid/support/test/internal/runner/RunnerArgs;->testSize:Ljava/lang/String;

    .line 104
    # getter for: Landroid/support/test/internal/runner/RunnerArgs$Builder;->annotation:Ljava/lang/String;
    invoke-static {p1}, Landroid/support/test/internal/runner/RunnerArgs$Builder;->access$900(Landroid/support/test/internal/runner/RunnerArgs$Builder;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Landroid/support/test/internal/runner/RunnerArgs;->annotation:Ljava/lang/String;

    .line 105
    # getter for: Landroid/support/test/internal/runner/RunnerArgs$Builder;->notAnnotations:Ljava/util/List;
    invoke-static {p1}, Landroid/support/test/internal/runner/RunnerArgs$Builder;->access$1000(Landroid/support/test/internal/runner/RunnerArgs$Builder;)Ljava/util/List;

    move-result-object v0

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Landroid/support/test/internal/runner/RunnerArgs;->notAnnotations:Ljava/util/List;

    .line 106
    # getter for: Landroid/support/test/internal/runner/RunnerArgs$Builder;->testTimeout:J
    invoke-static {p1}, Landroid/support/test/internal/runner/RunnerArgs$Builder;->access$1100(Landroid/support/test/internal/runner/RunnerArgs$Builder;)J

    move-result-wide v0

    iput-wide v0, p0, Landroid/support/test/internal/runner/RunnerArgs;->testTimeout:J

    .line 107
    # getter for: Landroid/support/test/internal/runner/RunnerArgs$Builder;->listeners:Ljava/util/List;
    invoke-static {p1}, Landroid/support/test/internal/runner/RunnerArgs$Builder;->access$1200(Landroid/support/test/internal/runner/RunnerArgs$Builder;)Ljava/util/List;

    move-result-object v0

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Landroid/support/test/internal/runner/RunnerArgs;->listeners:Ljava/util/List;

    .line 108
    # getter for: Landroid/support/test/internal/runner/RunnerArgs$Builder;->tests:Ljava/util/List;
    invoke-static {p1}, Landroid/support/test/internal/runner/RunnerArgs$Builder;->access$1300(Landroid/support/test/internal/runner/RunnerArgs$Builder;)Ljava/util/List;

    move-result-object v0

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Landroid/support/test/internal/runner/RunnerArgs;->tests:Ljava/util/List;

    .line 109
    # getter for: Landroid/support/test/internal/runner/RunnerArgs$Builder;->notTests:Ljava/util/List;
    invoke-static {p1}, Landroid/support/test/internal/runner/RunnerArgs$Builder;->access$1400(Landroid/support/test/internal/runner/RunnerArgs$Builder;)Ljava/util/List;

    move-result-object v0

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Landroid/support/test/internal/runner/RunnerArgs;->notTests:Ljava/util/List;

    .line 110
    # getter for: Landroid/support/test/internal/runner/RunnerArgs$Builder;->numShards:I
    invoke-static {p1}, Landroid/support/test/internal/runner/RunnerArgs$Builder;->access$1500(Landroid/support/test/internal/runner/RunnerArgs$Builder;)I

    move-result v0

    iput v0, p0, Landroid/support/test/internal/runner/RunnerArgs;->numShards:I

    .line 111
    # getter for: Landroid/support/test/internal/runner/RunnerArgs$Builder;->shardIndex:I
    invoke-static {p1}, Landroid/support/test/internal/runner/RunnerArgs$Builder;->access$1600(Landroid/support/test/internal/runner/RunnerArgs$Builder;)I

    move-result v0

    iput v0, p0, Landroid/support/test/internal/runner/RunnerArgs;->shardIndex:I

    .line 112
    # getter for: Landroid/support/test/internal/runner/RunnerArgs$Builder;->disableAnalytics:Z
    invoke-static {p1}, Landroid/support/test/internal/runner/RunnerArgs$Builder;->access$1700(Landroid/support/test/internal/runner/RunnerArgs$Builder;)Z

    move-result v0

    iput-boolean v0, p0, Landroid/support/test/internal/runner/RunnerArgs;->disableAnalytics:Z

    .line 113
    # getter for: Landroid/support/test/internal/runner/RunnerArgs$Builder;->appListeners:Ljava/util/List;
    invoke-static {p1}, Landroid/support/test/internal/runner/RunnerArgs$Builder;->access$1800(Landroid/support/test/internal/runner/RunnerArgs$Builder;)Ljava/util/List;

    move-result-object v0

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Landroid/support/test/internal/runner/RunnerArgs;->appListeners:Ljava/util/List;

    .line 114
    # getter for: Landroid/support/test/internal/runner/RunnerArgs$Builder;->idle:Z
    invoke-static {p1}, Landroid/support/test/internal/runner/RunnerArgs$Builder;->access$1900(Landroid/support/test/internal/runner/RunnerArgs$Builder;)Z

    move-result v0

    iput-boolean v0, p0, Landroid/support/test/internal/runner/RunnerArgs;->idle:Z

    .line 115
    return-void
.end method

.method synthetic constructor <init>(Landroid/support/test/internal/runner/RunnerArgs$Builder;Landroid/support/test/internal/runner/RunnerArgs$1;)V
    .locals 0
    .param p1, "x0"    # Landroid/support/test/internal/runner/RunnerArgs$Builder;
    .param p2, "x1"    # Landroid/support/test/internal/runner/RunnerArgs$1;

    .prologue
    .line 25
    invoke-direct {p0, p1}, Landroid/support/test/internal/runner/RunnerArgs;-><init>(Landroid/support/test/internal/runner/RunnerArgs$Builder;)V

    return-void
.end method
