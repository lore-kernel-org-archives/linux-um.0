Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IiIKj-0008NR-RK for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Oct 2007 16:29:49 -0700
Received: from py-out-1112.google.com ([64.233.166.177])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IiIKj-0002k0-E2
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Oct 2007 16:29:49 -0700
Received: by py-out-1112.google.com with SMTP id a25so4722902pyi
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 17 Oct 2007 16:29:48 -0700 (PDT)
Message-ID: <1f154f440710171629meb5a3ces92b8fdeacc371857@mail.gmail.com>
Date: Wed, 17 Oct 2007 19:29:47 -0400
From: Hrishikesh <hrishikesh.amur@gmail.com>
In-Reply-To: <20071017204527.GB12812@c2.user-mode-linux.org>
MIME-Version: 1.0
References: <1f154f440710161936h4800b0c5nb3140ff504212625@mail.gmail.com>
	<20071017155504.GD9497@c2.user-mode-linux.org>
	<1f154f440710170916j4fdb857fw40c9b2fd2b66f63f@mail.gmail.com>
	<20071017171920.GA10388@c2.user-mode-linux.org>
	<1f154f440710171243x40898f8bq386c91c59789fb42@mail.gmail.com>
	<20071017204527.GB12812@c2.user-mode-linux.org>
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
Content-Type: multipart/mixed; boundary="===============1476567139=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

--===============1476567139==
Content-Type: multipart/alternative; 
	boundary="----=_Part_47417_6561631.1192663787200"

------=_Part_47417_6561631.1192663787200
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

No, I think I haven't been clear enough. The story is right :-) When it is
"busy-looping" like in the second case is when the C3 residency comes down,
as expected. Like you said, it looks broken, and has to be fixed.
Regards,
Hrishikesh

On 10/17/07, Jeff Dike <jdike@addtoit.com> wrote:
>
> On Wed, Oct 17, 2007 at 03:43:01PM -0400, Hrishikesh wrote:
> > Ok the straces do seem to tell the story; they follow below:
>
> Except they're telling the wrong story:
>
> > for the case where is the kernel is patched and NO_HZ enabled,
>
> > {it_interval={0, 0}, it_value={0, 91986}}) = 0
> > nanosleep({0, 91986000}, {0, 91986000}) = 0
>
> .1 sec
>
> > {it_interval={0, 0}, it_value={0, 291955}}) = 0
> > nanosleep({0, 291955000}, {0, 291955000}) = 0
>
> .3 sec
>
> > {it_interval={0, 0}, it_value={1, 701741}}) = 0
> > nanosleep({1, 701741000}, {1, 701741000}) = 0
>
> 1.7 sec
>
> > for the case where the kernel is patched, but NO_HZ is __not__ enabled,
> > there is a do_nanosleep() every 100 or so us.
> >
> > setitimer(ITIMER_VIRTUAL, {it_interval={0, 0}, it_value={0, 0}},
> > {it_interval={0, 0}, it_value={0, 0}}) = 0
> > nanosleep({0, 0}, {0, 0})               = 0
>
> This actually looks very broken - it's sleeping for no time,
> practically a busy-loop.  And this case is keeping the host in C3
> longer than the second-long sleeps in the first case?
>
>                                 Jeff
>
> --
> Work email - jdike at linux dot intel dot com
>

------=_Part_47417_6561631.1192663787200
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

No, I think I haven&#39;t been clear enough. The story is right :-) When it is &quot;busy-looping&quot; like in the second case is when the C3 residency comes down, as expected. Like you said, it looks broken, and has to be fixed. 
<br>Regards,<br>Hrishikesh<br><br><div><span class="gmail_quote">On 10/17/07, <b class="gmail_sendername">Jeff Dike</b> &lt;<a href="mailto:jdike@addtoit.com">jdike@addtoit.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Wed, Oct 17, 2007 at 03:43:01PM -0400, Hrishikesh wrote:<br>&gt; Ok the straces do seem to tell the story; they follow below:<br><br>Except they&#39;re telling the wrong story:<br><br>&gt; for the case where is the kernel is patched and NO_HZ enabled,
<br><br>&gt; {it_interval={0, 0}, it_value={0, 91986}}) = 0<br>&gt; nanosleep({0, 91986000}, {0, 91986000}) = 0<br><br>.1 sec<br><br>&gt; {it_interval={0, 0}, it_value={0, 291955}}) = 0<br>&gt; nanosleep({0, 291955000}, {0, 291955000}) = 0
<br><br>.3 sec<br><br>&gt; {it_interval={0, 0}, it_value={1, 701741}}) = 0<br>&gt; nanosleep({1, 701741000}, {1, 701741000}) = 0<br><br>1.7 sec<br><br>&gt; for the case where the kernel is patched, but NO_HZ is __not__ enabled,
<br>&gt; there is a do_nanosleep() every 100 or so us.<br>&gt;<br>&gt; setitimer(ITIMER_VIRTUAL, {it_interval={0, 0}, it_value={0, 0}},<br>&gt; {it_interval={0, 0}, it_value={0, 0}}) = 0<br>&gt; nanosleep({0, 0}, {0, 0})&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0
<br><br>This actually looks very broken - it&#39;s sleeping for no time,<br>practically a busy-loop.&nbsp;&nbsp;And this case is keeping the host in C3<br>longer than the second-long sleeps in the first case?<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Jeff
<br><br>--<br>Work email - jdike at linux dot intel dot com<br></blockquote></div><br>

------=_Part_47417_6561631.1192663787200--


--===============1476567139==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============1476567139==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1476567139==--

