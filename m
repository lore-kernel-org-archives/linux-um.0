Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IiEnS-0002n6-Or for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Oct 2007 12:43:14 -0700
Received: from nz-out-0506.google.com ([64.233.162.231])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IiEnO-0001OB-JB
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Oct 2007 12:43:12 -0700
Received: by nz-out-0506.google.com with SMTP id f1so6130672nzc
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 17 Oct 2007 12:43:09 -0700 (PDT)
Message-ID: <1f154f440710171243x40898f8bq386c91c59789fb42@mail.gmail.com>
Date: Wed, 17 Oct 2007 15:43:01 -0400
From: Hrishikesh <hrishikesh.amur@gmail.com>
In-Reply-To: <20071017171920.GA10388@c2.user-mode-linux.org>
MIME-Version: 1.0
References: <1f154f440710161936h4800b0c5nb3140ff504212625@mail.gmail.com>
	<20071017155504.GD9497@c2.user-mode-linux.org>
	<1f154f440710170916j4fdb857fw40c9b2fd2b66f63f@mail.gmail.com>
	<20071017171920.GA10388@c2.user-mode-linux.org>
Subject: Re: [uml-devel] Dramatic drop in C3 state residency with NO_HZ patches
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1843095191=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

--===============1843095191==
Content-Type: multipart/alternative; 
	boundary="----=_Part_46270_26429711.1192650181303"

------=_Part_46270_26429711.1192650181303
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Ok the straces do seem to tell the story; they follow below:

for the case where is the kernel is patched and NO_HZ enabled,

waitpid(3989, [{WIFSTOPPED(s) && WSTOPSIG(s) == 133}], WSTOPPED) = 3989
gettimeofday({1192649136, 409637}, NULL) = 0
gettimeofday({1192649136, 409698}, NULL) = 0
setitimer(ITIMER_VIRTUAL, {it_interval={0, 0}, it_value={0, 90000}}, NULL) =
0
setitimer(ITIMER_VIRTUAL, {it_interval={0, 0}, it_value={0, 0}},
{it_interval={0, 0}, it_value={0, 91986}}) = 0
nanosleep({0, 91986000}, {0, 91986000}) = 0
gettimeofday({1192649136, 502142}, NULL) = 0
gettimeofday({1192649136, 502201}, NULL) = 0
gettimeofday({1192649136, 502260}, NULL) = 0
gettimeofday({1192649136, 502352}, NULL) = 0
gettimeofday({1192649136, 502410}, NULL) = 0
gettimeofday({1192649136, 502481}, NULL) = 0
gettimeofday({1192649136, 502578}, NULL) = 0
setitimer(ITIMER_VIRTUAL, {it_interval={0, 0}, it_value={0, 10000}}, NULL) =
0
gettimeofday({1192649136, 502750}, NULL) = 0
gettimeofday({1192649136, 502814}, NULL) = 0
setitimer(ITIMER_VIRTUAL, {it_interval={0, 0}, it_value={0, 290000}}, NULL)
= 0
setitimer(ITIMER_VIRTUAL, {it_interval={0, 0}, it_value={0, 0}},
{it_interval={0, 0}, it_value={0, 291955}}) = 0
nanosleep({0, 291955000}, {0, 291955000}) = 0
gettimeofday({1192649136, 795308}, NULL) = 0
gettimeofday({1192649136, 795368}, NULL) = 0
gettimeofday({1192649136, 795427}, NULL) = 0
gettimeofday({1192649136, 795486}, NULL) = 0
gettimeofday({1192649136, 795544}, NULL) = 0
gettimeofday({1192649136, 795616}, NULL) = 0
gettimeofday({1192649136, 795675}, NULL) = 0
setitimer(ITIMER_VIRTUAL, {it_interval={0, 0}, it_value={0, 10000}}, NULL) =
0
gettimeofday({1192649136, 795815}, NULL) = 0
gettimeofday({1192649136, 795876}, NULL) = 0
setitimer(ITIMER_VIRTUAL, {it_interval={0, 0}, it_value={1, 700000}}, NULL)
= 0
setitimer(ITIMER_VIRTUAL, {it_interval={0, 0}, it_value={0, 0}},
{it_interval={0, 0}, it_value={1, 701741}}) = 0
nanosleep({1, 701741000}, {1, 701741000}) = 0


for the case where the kernel is patched, but NO_HZ is __not__ enabled,
there is a do_nanosleep() every 100 or so us.

setitimer(ITIMER_VIRTUAL, {it_interval={0, 0}, it_value={0, 0}},
{it_interval={0, 0}, it_value={0, 0}}) = 0
nanosleep({0, 0}, {0, 0})               = 0
gettimeofday({1192648953, 436325}, NULL) = 0
setitimer(ITIMER_VIRTUAL, {it_interval={0, 0}, it_value={0, 0}},
{it_interval={0, 0}, it_value={0, 0}}) = 0
nanosleep({0, 0}, {0, 0})               = 0
gettimeofday({1192648953, 436434}, NULL) = 0
setitimer(ITIMER_VIRTUAL, {it_interval={0, 0}, it_value={0, 0}},
{it_interval={0, 0}, it_value={0, 0}}) = 0
nanosleep({0, 0}, {0, 0})               = 0
gettimeofday({1192648953, 436532}, NULL) = 0
setitimer(ITIMER_VIRTUAL, {it_interval={0, 0}, it_value={0, 0}},
{it_interval={0, 0}, it_value={0, 0}}) = 0
nanosleep({0, 0}, {0, 0})               = 0
gettimeofday({1192648953, 436629}, NULL) = 0
setitimer(ITIMER_VIRTUAL, {it_interval={0, 0}, it_value={0, 0}},
{it_interval={0, 0}, it_value={0, 0}}) = 0
nanosleep({0, 0}, {0, 0})               = 0
gettimeofday({1192648953, 436725}, NULL) = 0
setitimer(ITIMER_VIRTUAL, {it_interval={0, 0}, it_value={0, 0}},
{it_interval={0, 0}, it_value={0, 0}}) = 0
nanosleep({0, 0}, {0, 0})               = 0
gettimeofday({1192648953, 436822}, NULL) = 0
setitimer(ITIMER_VIRTUAL, {it_interval={0, 0}, it_value={0, 0}},
{it_interval={0, 0}, it_value={0, 0}}) = 0
nanosleep({0, 0}, {0, 0})               = 0
gettimeofday({1192648953, 436919}, NULL) = 0
setitimer(ITIMER_VIRTUAL, {it_interval={0, 0}, it_value={0, 0}},
{it_interval={0, 0}, it_value={0, 0}}) = 0
nanosleep({0, 0}, {0, 0})               = 0
gettimeofday({1192648953, 437015}, NULL) = 0
setitimer(ITIMER_VIRTUAL, {it_interval={0, 0}, it_value={0, 0}},
{it_interval={0, 0}, it_value={0, 0}}) = 0
nanosleep({0, 0}, {0, 0})               = 0

Regards,
Hrishikesh


On 10/17/07, Jeff Dike <jdike@addtoit.com> wrote:
>
> On Wed, Oct 17, 2007 at 12:16:18PM -0400, Hrishikesh wrote:
> > This is when I patch the UML kernel with the NO_HZ patches that you put
> up
> > last month.. on 2.6.23-rc6-mm1.
>
> Hmmm, that's exactly the opposite of what I would expect.  A idle
> non-NO_HZ UML should be waking up 100 times/sec, while I see much
> longer sleeps with an idle NO_HZ UML, up to 2-3 seconds.
>
> Can you strace both cases and see how often the NO_HZ UML is waking up
> compared to the non-NO_HZ one?
>
>                                 Jeff
>
> --
> Work email - jdike at linux dot intel dot com
>

------=_Part_46270_26429711.1192650181303
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Ok the straces do seem to tell the story; they follow below:<br><br>for the case where is the kernel is patched and NO_HZ enabled,<br><br>waitpid(3989, [{WIFSTOPPED(s) &amp;&amp; WSTOPSIG(s) == 133}], WSTOPPED) = 3989<br>gettimeofday({1192649136, 409637}, NULL) = 0
<br>gettimeofday({1192649136, 409698}, NULL) = 0<br>setitimer(ITIMER_VIRTUAL, {it_interval={0, 0}, it_value={0, 90000}}, NULL) = 0<br>setitimer(ITIMER_VIRTUAL, {it_interval={0, 0}, it_value={0, 0}}, {it_interval={0, 0}, it_value={0, 91986}}) = 0
<br>nanosleep({0, 91986000}, {0, 91986000}) = 0<br>gettimeofday({1192649136, 502142}, NULL) = 0<br>gettimeofday({1192649136, 502201}, NULL) = 0<br>gettimeofday({1192649136, 502260}, NULL) = 0<br>gettimeofday({1192649136, 502352}, NULL) = 0
<br>gettimeofday({1192649136, 502410}, NULL) = 0<br>gettimeofday({1192649136, 502481}, NULL) = 0<br>gettimeofday({1192649136, 502578}, NULL) = 0<br>setitimer(ITIMER_VIRTUAL, {it_interval={0, 0}, it_value={0, 10000}}, NULL) = 0
<br>gettimeofday({1192649136, 502750}, NULL) = 0<br>gettimeofday({1192649136, 502814}, NULL) = 0<br>setitimer(ITIMER_VIRTUAL, {it_interval={0, 0}, it_value={0, 290000}}, NULL) = 0<br>setitimer(ITIMER_VIRTUAL, {it_interval={0, 0}, it_value={0, 0}}, {it_interval={0, 0}, it_value={0, 291955}}) = 0
<br>nanosleep({0, 291955000}, {0, 291955000}) = 0<br>gettimeofday({1192649136, 795308}, NULL) = 0<br>gettimeofday({1192649136, 795368}, NULL) = 0<br>gettimeofday({1192649136, 795427}, NULL) = 0<br>gettimeofday({1192649136, 795486}, NULL) = 0
<br>gettimeofday({1192649136, 795544}, NULL) = 0<br>gettimeofday({1192649136, 795616}, NULL) = 0<br>gettimeofday({1192649136, 795675}, NULL) = 0<br>setitimer(ITIMER_VIRTUAL, {it_interval={0, 0}, it_value={0, 10000}}, NULL) = 0
<br>gettimeofday({1192649136, 795815}, NULL) = 0<br>gettimeofday({1192649136, 795876}, NULL) = 0<br>setitimer(ITIMER_VIRTUAL, {it_interval={0, 0}, it_value={1, 700000}}, NULL) = 0<br>setitimer(ITIMER_VIRTUAL, {it_interval={0, 0}, it_value={0, 0}}, {it_interval={0, 0}, it_value={1, 701741}}) = 0
<br>nanosleep({1, 701741000}, {1, 701741000}) = 0<br><br><br>for the case where the kernel is patched, but NO_HZ is __not__ enabled, there is a do_nanosleep() every 100 or so us.<br><br>setitimer(ITIMER_VIRTUAL, {it_interval={0, 0}, it_value={0, 0}}, {it_interval={0, 0}, it_value={0, 0}}) = 0
<br>nanosleep({0, 0}, {0, 0})&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0<br>gettimeofday({1192648953, 436325}, NULL) = 0<br>setitimer(ITIMER_VIRTUAL, {it_interval={0, 0}, it_value={0, 0}}, {it_interval={0, 0}, it_value={0, 0}}) = 0<br>nanosleep({0, 0}, {0, 0})&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0
<br>gettimeofday({1192648953, 436434}, NULL) = 0<br>setitimer(ITIMER_VIRTUAL, {it_interval={0, 0}, it_value={0, 0}}, {it_interval={0, 0}, it_value={0, 0}}) = 0<br>nanosleep({0, 0}, {0, 0})&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0<br>gettimeofday({1192648953, 436532}, NULL) = 0
<br>setitimer(ITIMER_VIRTUAL, {it_interval={0, 0}, it_value={0, 0}}, {it_interval={0, 0}, it_value={0, 0}}) = 0<br>nanosleep({0, 0}, {0, 0})&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0<br>gettimeofday({1192648953, 436629}, NULL) = 0<br>setitimer(ITIMER_VIRTUAL, {it_interval={0, 0}, it_value={0, 0}}, {it_interval={0, 0}, it_value={0, 0}}) = 0
<br>nanosleep({0, 0}, {0, 0})&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0<br>gettimeofday({1192648953, 436725}, NULL) = 0<br>setitimer(ITIMER_VIRTUAL, {it_interval={0, 0}, it_value={0, 0}}, {it_interval={0, 0}, it_value={0, 0}}) = 0<br>nanosleep({0, 0}, {0, 0})&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0
<br>gettimeofday({1192648953, 436822}, NULL) = 0<br>setitimer(ITIMER_VIRTUAL, {it_interval={0, 0}, it_value={0, 0}}, {it_interval={0, 0}, it_value={0, 0}}) = 0<br>nanosleep({0, 0}, {0, 0})&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0<br>gettimeofday({1192648953, 436919}, NULL) = 0
<br>setitimer(ITIMER_VIRTUAL, {it_interval={0, 0}, it_value={0, 0}}, {it_interval={0, 0}, it_value={0, 0}}) = 0<br>nanosleep({0, 0}, {0, 0})&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0<br>gettimeofday({1192648953, 437015}, NULL) = 0<br>setitimer(ITIMER_VIRTUAL, {it_interval={0, 0}, it_value={0, 0}}, {it_interval={0, 0}, it_value={0, 0}}) = 0
<br>nanosleep({0, 0}, {0, 0})&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0<br><br>Regards,<br>Hrishikesh<br><br><br><div><span class="gmail_quote">On 10/17/07, <b class="gmail_sendername">Jeff Dike</b> &lt;<a href="mailto:jdike@addtoit.com">jdike@addtoit.com
</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">On Wed, Oct 17, 2007 at 12:16:18PM -0400, Hrishikesh wrote:<br>&gt; This is when I patch the UML kernel with the NO_HZ patches that you put up
<br>&gt; last month.. on 2.6.23-rc6-mm1.<br><br>Hmmm, that&#39;s exactly the opposite of what I would expect.&nbsp;&nbsp;A idle<br>non-NO_HZ UML should be waking up 100 times/sec, while I see much<br>longer sleeps with an idle NO_HZ UML, up to 2-3 seconds.
<br><br>Can you strace both cases and see how often the NO_HZ UML is waking up<br>compared to the non-NO_HZ one?<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Jeff<br><br>--<br>Work email - jdike at linux dot intel dot com<br></blockquote>
</div><br>

------=_Part_46270_26429711.1192650181303--


--===============1843095191==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============1843095191==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1843095191==--

