Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <553D4890.2010708@nod.at>
Date: Sun, 26 Apr 2015 22:20:32 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <E1Xg9cr-0007LK-S6@www17.your-server.de>	<5444DC3F.20601@nod.at>	<1429905520.157088.6.camel@m3y3r.de> <CAFLxGvxq900TTuJ1jAfNx3xTrUTbE3vZkMZ_H=FvsPg3eck9ww@mail.gmail.com>
In-Reply-To: <CAFLxGvxq900TTuJ1jAfNx3xTrUTbE3vZkMZ_H=FvsPg3eck9ww@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------030508080901070401030507"
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [uml-devel] [UM] Long loop in __getnsdayoftime() after resume
 from ram
To: Thomas Meyer <thomas@m3y3r.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------030508080901070401030507
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

Am 26.04.2015 um 20:32 schrieb Richard Weinberger:
> On Fri, Apr 24, 2015 at 9:58 PM, Thomas Meyer <thomas@m3y3r.de> wrote:
>> Any ideas?
> 
> Can you give the attached patch a try?
> Let's see if it proves my theory.
> Looks like UML's clocksource needs fixing.

Please give also this patch a try.
I should fix your issue in a sane way.

Thanks,
//richard

--------------030508080901070401030507
Content-Type: text/x-patch;
 name="uml_mono.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="uml_mono.diff"

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index d824528..b386cee 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -244,6 +244,7 @@ extern int timer_one_shot(int ticks);
 extern long long disable_timer(void);
 extern void uml_idle_timer(void);
 extern long long os_nsecs(void);
+extern long long os_nsecs_monotonic(void);
 
 /* skas/mem.c */
 extern long run_syscall_stub(struct mm_id * mm_idp,
diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index 117568d..399687c 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -67,7 +67,7 @@ static irqreturn_t um_timer(int irq, void *dev)
 
 static cycle_t itimer_read(struct clocksource *cs)
 {
-	return os_nsecs() / 1000;
+	return os_nsecs_monotonic() / 1000;
 }
 
 static struct clocksource itimer_clocksource = {
diff --git a/arch/um/os-Linux/time.c b/arch/um/os-Linux/time.c
index e9824d5..0ef8faa 100644
--- a/arch/um/os-Linux/time.c
+++ b/arch/um/os-Linux/time.c
@@ -79,6 +79,15 @@ long long os_nsecs(void)
 	return timeval_to_ns(&tv);
 }
 
+long long os_nsecs_monotonic(void)
+{
+	struct timespec tp;
+
+	clock_gettime(CLOCK_MONOTONIC, &tp);
+
+	return ((long long)tp.tv_sec * UM_NSEC_PER_SEC) + tp.tv_nsec;
+}
+
 #ifdef UML_CONFIG_NO_HZ_COMMON
 static int after_sleep_interval(struct timespec *ts)
 {

--------------030508080901070401030507--
