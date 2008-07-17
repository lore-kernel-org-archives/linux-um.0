Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KJLWR-0004Ev-Ho for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Jul 2008 21:55:19 -0700
Received: from smtp-out.google.com ([216.239.33.17])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KJLWO-0002ey-KC
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Jul 2008 21:55:19 -0700
Received: from spaceape8.eur.corp.google.com (spaceape8.eur.corp.google.com
	[172.28.16.142]) by smtp-out3.google.com with ESMTP id m6H4tBoH009018
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 17 Jul 2008 05:55:11 +0100
Received: from rv-out-0506.google.com (rvfb25.prod.google.com [10.140.179.25])
	by spaceape8.eur.corp.google.com with ESMTP id m6H4svOk026581
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 17 Jul 2008 05:55:10 +0100
Received: by rv-out-0506.google.com with SMTP id b25so6065946rvf.37
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 16 Jul 2008 21:55:10 -0700 (PDT)
Message-ID: <5df78e1d0807162155t594936c9qe5bc1616fae97f77@mail.gmail.com>
Date: Thu, 17 Jul 2008 12:55:09 +0800
From: "Jiaying Zhang" <jiayingz@google.com>
In-Reply-To: <5df78e1d0807160252j1b610c41la1a2f5092ae04be7@mail.gmail.com>
MIME-Version: 1.0
References: <5df78e1d0807030053x8a9bfabo582ea78e74b2c65b@mail.gmail.com>
	<20080703135639.GA8262@c2.user-mode-linux.org>
	<5df78e1d0807031806s74c13c84idadc62c1d1e0e93b@mail.gmail.com>
	<5df78e1d0807091925q64c0121fk3d33c37df8d80d18@mail.gmail.com>
	<20080710170210.GB18429@c2.user-mode-linux.org>
	<5df78e1d0807140206m43291128t32f1489177ad6e3d@mail.gmail.com>
	<20080714144612.GA5751@c2.user-mode-linux.org>
	<5df78e1d0807160252j1b610c41la1a2f5092ae04be7@mail.gmail.com>
Subject: Re: [uml-devel] 2.6.25 uml kernel crashes when it calls down() on a
	semaphore with zero counter
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0455895903=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

--===============0455895903==
Content-Type: multipart/alternative; 
	boundary="----=_Part_34076_28377461.1216270509925"

------=_Part_34076_28377461.1216270509925
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The patch below solves the 2.6.25 uml crash problem for me. Looks like the
problem should be away in 2.6.26 kernel because down_interruptible has
changed to the C code since 2.6.26. But I got kernel panic while booting
the 2.6.26 kernel :(.

--- linux-2.6.25.4/lib/semaphore-sleepers.c     2008-05-15
23:00:12.000000000 +0800
+++ linux-2.6.25.4-new/lib/semaphore-sleepers.c 2008-07-17
12:20:47.000000000 +0800
@@ -48,12 +48,12 @@
  *    we cannot lose wakeup events.
  */

-void __up(struct semaphore *sem)
+asmregparm void __up(struct semaphore *sem)
 {
        wake_up(&sem->wait);
 }

-void __sched __down(struct semaphore *sem)
+asmregparm void __sched __down(struct semaphore *sem)
 {
        struct task_struct *tsk = current;
        DECLARE_WAITQUEUE(wait, tsk);
@@ -90,7 +90,7 @@ void __sched __down(struct semaphore *se
        tsk->state = TASK_RUNNING;
 }

-int __sched __down_interruptible(struct semaphore *sem)
+asmregparm int __sched __down_interruptible(struct semaphore *sem)
 {
        int retval = 0;
        struct task_struct *tsk = current;
@@ -153,7 +153,7 @@ int __sched __down_interruptible(struct
  * single "cmpxchg" without failure cases,
  * but then it wouldn't work on a 386.
  */
-int __down_trylock(struct semaphore *sem)
+asmregparm int __down_trylock(struct semaphore *sem)
 {
        int sleepers;
        unsigned long flags;

Jiaying

On Wed, Jul 16, 2008 at 5:52 PM, Jiaying Zhang <jiayingz@google.com> wrote:

>
>
> On Mon, Jul 14, 2008 at 10:46 PM, Jeff Dike <jdike@addtoit.com> wrote:
>
>> On Mon, Jul 14, 2008 at 05:06:49PM +0800, Jiaying Zhang wrote:
>> > The 2.6.24 kernels are OK, but I have seen this problem with all of the
>> > 2.6.25 kernels I have tried. There have been a lot of changes between
>> > 2.6.24 kernels and 2.6.25 kernels. I am not sure which one may lead
>> > to this problem.
>>
>> So bisect it.
>
>
> The problem seems to be related to the getting rid of fastcall changes
> introduced in 2.6.25 kernels. I found the problem started to happen from
> commit 82f74e7159749cc511ebf5954a7b9ea6ad634949: x86: unify
> include/asm-x86/linkage_[32|64].h.
> After that, several commits related to __down_interruptible had been
> checked in, but they did not solve the crashing problem I saw.
> In particular, I thought the d50efc6c40620b2e11648cac64ebf4a824e40382
> x86: fix UML and -regparm=3 commit would solve the problem because it
> adds the asmregparm macro that is the same as fastcall and uses the macro
> for  __down_failed_interruptible declaration. Unfortunately, I tried that
> version
> of git code and saw the same problem happened.
>
>
>> > Looks like the problem happens when __down_interruptible is called.
>> > I checked the semaphore passed to __down_interruptible under gdb
>> > and found it was corrupted:
>> > (gdb) f 18
>> > #18 __down_interruptible (sem=0x9f68d08) at include/linux/list.h:50
>> > 50              prev->next = new;
>> > (gdb) p sem
>> > $15 = (struct semaphore *) 0x9f68d08
>> > (gdb) p *sem
>> > $16 = {count = {counter = -268435295}, sleepers = 4, wait = {lock =
>> > {raw_lock = {<No data fields>}}, task_list = {
>> >       next = 0x9f68d5c, prev = 0x18124}}}
>> >
>> > But the semaphore looks correct before calling down_interruptible:
>>
>> What's the problem with debugging this, then?  You step through the
>> code starting when the semaphore is good and see exactly when it gets
>> corrupted.
>>
>
> Yes. Looks like the corruption happens when __down_failed_interruptible()
> calls __down_interruptible() and it has something to do with the 2.6.25's
> x86
> gcc attribute changes.
>
> Jiaying
>
>

------=_Part_34076_28377461.1216270509925
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">The patch below solves the 2.6.25 uml crash problem for me. Looks like the<br>problem should be away in 2.6.26 kernel because down_interruptible has <br>changed to the C code since <a href="http://2.6.26.">2.6.26.</a> But I got kernel panic while booting<br>
the 2.6.26 kernel :(.<br><br>--- linux-2.6.25.4/lib/semaphore-sleepers.c&nbsp;&nbsp;&nbsp;&nbsp; 2008-05-15 23:00:12.000000000 +0800<br>+++ linux-2.6.25.4-new/lib/semaphore-sleepers.c 2008-07-17 12:20:47.000000000 +0800<br>@@ -48,12 +48,12 @@<br>
&nbsp; *&nbsp;&nbsp;&nbsp; we cannot lose wakeup events.<br>&nbsp; */<br><br>-void __up(struct semaphore *sem)<br>+asmregparm void __up(struct semaphore *sem)<br>&nbsp;{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wake_up(&amp;sem-&gt;wait);<br>&nbsp;}<br><br>-void __sched __down(struct semaphore *sem)<br>
+asmregparm void __sched __down(struct semaphore *sem)<br>&nbsp;{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct task_struct *tsk = current;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DECLARE_WAITQUEUE(wait, tsk);<br>@@ -90,7 +90,7 @@ void __sched __down(struct semaphore *se<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tsk-&gt;state = TASK_RUNNING;<br>
&nbsp;}<br><br>-int __sched __down_interruptible(struct semaphore *sem)<br>+asmregparm int __sched __down_interruptible(struct semaphore *sem)<br>&nbsp;{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int retval = 0;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct task_struct *tsk = current;<br>@@ -153,7 +153,7 @@ int __sched __down_interruptible(struct<br>
&nbsp; * single &quot;cmpxchg&quot; without failure cases,<br>&nbsp; * but then it wouldn&#39;t work on a 386.<br>&nbsp; */<br>-int __down_trylock(struct semaphore *sem)<br>+asmregparm int __down_trylock(struct semaphore *sem)<br>&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int sleepers;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long flags;<br><br>Jiaying<br><br><div class="gmail_quote">On Wed, Jul 16, 2008 at 5:52 PM, Jiaying Zhang &lt;<a href="mailto:jiayingz@google.com">jiayingz@google.com</a>&gt; wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br><br><div class="gmail_quote"><div class="Ih2E3d">On Mon, Jul 14, 2008 at 10:46 PM, Jeff Dike &lt;<a href="mailto:jdike@addtoit.com" target="_blank">jdike@addtoit.com</a>&gt; wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div>On Mon, Jul 14, 2008 at 05:06:49PM +0800, Jiaying Zhang wrote:<br>
&gt; The 2.6.24 kernels are OK, but I have seen this problem with all of the<br>
&gt; 2.6.25 kernels I have tried. There have been a lot of changes between<br>
&gt; 2.6.24 kernels and 2.6.25 kernels. I am not sure which one may lead<br>
&gt; to this problem.<br>
<br>
</div>So bisect it.</blockquote></div><div><br>The problem seems to be related to the getting rid of fastcall changes <br>introduced in 2.6.25 kernels. I found the problem started to happen from<br>commit 82f74e7159749cc511ebf5954a7b9ea6ad634949: x86: unify include/asm-x86/linkage_[32|64].h.<br>

After that, several commits related to __down_interruptible had been<br>checked in, but they did not solve the crashing problem I saw.<br>In particular, I thought the d50efc6c40620b2e11648cac64ebf4a824e40382<br>
x86: fix UML and -regparm=3 commit would solve the problem because it<br>adds the asmregparm macro that is the same as fastcall and uses the macro<br>for&nbsp; __down_failed_interruptible declaration. Unfortunately, I tried that version<br>

of git code and saw the same problem happened.<br>
<br>
</div><div class="Ih2E3d"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><br>
&gt; Looks like the problem happens when __down_interruptible is called.<br>
&gt; I checked the semaphore passed to __down_interruptible under gdb<br>
&gt; and found it was corrupted:<br>
&gt; (gdb) f 18<br>
&gt; #18 __down_interruptible (sem=0x9f68d08) at include/linux/list.h:50<br>
&gt; 50 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;prev-&gt;next = new;<br>
&gt; (gdb) p sem<br>
&gt; $15 = (struct semaphore *) 0x9f68d08<br>
&gt; (gdb) p *sem<br>
&gt; $16 = {count = {counter = -268435295}, sleepers = 4, wait = {lock =<br>
&gt; {raw_lock = {&lt;No data fields&gt;}}, task_list = {<br>
&gt; &nbsp; &nbsp; &nbsp; next = 0x9f68d5c, prev = 0x18124}}}<br>
&gt;<br>
&gt; But the semaphore looks correct before calling down_interruptible:<br>
<br>
</div>What&#39;s the problem with debugging this, then? &nbsp;You step through the<br>
code starting when the semaphore is good and see exactly when it gets<br>
corrupted.<br>
<div><div></div><div></div></div></blockquote></div><div><br>Yes. Looks like the corruption happens when __down_failed_interruptible()<br>calls __down_interruptible() and it has something to do with the 2.6.25&#39;s x86<br>

gcc attribute changes.<br><br>Jiaying<br><br></div></div>
</blockquote></div><br></div>

------=_Part_34076_28377461.1216270509925--


--===============0455895903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============0455895903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0455895903==--

