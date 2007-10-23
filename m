Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IkPJL-0007TW-I3 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Oct 2007 12:21:09 -0700
Received: from nz-out-0506.google.com ([64.233.162.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IkPJK-0003wU-3C
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Oct 2007 12:21:07 -0700
Received: by nz-out-0506.google.com with SMTP id f1so3038723nzc
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 23 Oct 2007 12:21:05 -0700 (PDT)
Message-ID: <1f154f440710231221r76d63ec2h640e95c7afa05a6a@mail.gmail.com>
Date: Tue, 23 Oct 2007 16:21:03 -0300
From: Hrishikesh <hrishikesh.amur@gmail.com>
In-Reply-To: <20071018200432.GA9204@c2.user-mode-linux.org>
MIME-Version: 1.0
References: <1f154f440710161936h4800b0c5nb3140ff504212625@mail.gmail.com>
	<20071017155504.GD9497@c2.user-mode-linux.org>
	<1f154f440710170916j4fdb857fw40c9b2fd2b66f63f@mail.gmail.com>
	<20071017171920.GA10388@c2.user-mode-linux.org>
	<1f154f440710171243x40898f8bq386c91c59789fb42@mail.gmail.com>
	<20071017204527.GB12812@c2.user-mode-linux.org>
	<1f154f440710171629meb5a3ces92b8fdeacc371857@mail.gmail.com>
	<20071018200432.GA9204@c2.user-mode-linux.org>
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
Content-Type: multipart/mixed; boundary="===============0317563900=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

--===============0317563900==
Content-Type: multipart/alternative; 
	boundary="----=_Part_4019_21318122.1193167264169"

------=_Part_4019_21318122.1193167264169
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hey Jeff,
Yes, that double negative was a slipup. I did get some numbers out and they
look pretty good. I ran upto 5 instances of UML simultaneously and in the
tickful case, each instance adds roughly about 100 wakeups per second. So
after 5 instances, C3 residency comes down to about 95% when all the
instances are simply idling. With NO_HZ applied, the change is minimal with
C3 residency still approximately 98%. UML is not even among the top three of
the bad-list of wakers-up :-)
Hrishikesh

On 10/18/07, Jeff Dike <jdike@addtoit.com> wrote:
>
> On Wed, Oct 17, 2007 at 07:29:47PM -0400, Hrishikesh wrote:
> > No, I think I haven't been clear enough. The story is right :-) When it
> is
> > "busy-looping" like in the second case is when the C3 residency comes
> down,
> > as expected. Like you said, it looks broken, and has to be fixed.
>
> Yes, your original post was a bit confusing:
>
> > This happens when you run a
> > patched kernel but without the NO_HZ and HR timers options disabled.
>
> To my highly logical mind, that double-negative says that you saw the
> C3 drop with NO_HZ and hrtimers enabled.
>
> There was also this, which I paid insufficient attention to:
>
> > This does not happen when the tickless option _is_ enabled.
>
> However, it does look like the tickless support induces UML into a
> busy loop when NO_HZ is disabled.
>
> BTW, can you measure C3 time with a before-NO_HZ UML, so we can see
> that NO_HZ has some sort of benefit on power consumption?
>
>                                 Jeff
>
> --
> Work email - jdike at linux dot intel dot com
>

------=_Part_4019_21318122.1193167264169
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hey Jeff,<br>Yes, that double negative was a slipup. I did get some numbers out and they look pretty good. I ran upto 5 instances of UML simultaneously and in the tickful case, each instance adds roughly about 100 wakeups per second. So after 5 instances, C3 residency comes down to about 95% when all the instances are simply idling. With NO_HZ applied, the change is minimal with C3 residency still approximately 98%. UML is not even among the top three of the bad-list of wakers-up :-)
<br>Hrishikesh<br><br><div><span class="gmail_quote">On 10/18/07, <b class="gmail_sendername">Jeff Dike</b> &lt;<a href="mailto:jdike@addtoit.com">jdike@addtoit.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Wed, Oct 17, 2007 at 07:29:47PM -0400, Hrishikesh wrote:<br>&gt; No, I think I haven&#39;t been clear enough. The story is right :-) When it is<br>&gt; &quot;busy-looping&quot; like in the second case is when the C3 residency comes down,
<br>&gt; as expected. Like you said, it looks broken, and has to be fixed.<br><br>Yes, your original post was a bit confusing:<br><br>&gt; This happens when you run a<br>&gt; patched kernel but without the NO_HZ and HR timers options disabled.
<br><br>To my highly logical mind, that double-negative says that you saw the<br>C3 drop with NO_HZ and hrtimers enabled.<br><br>There was also this, which I paid insufficient attention to:<br><br>&gt; This does not happen when the tickless option _is_ enabled.
<br><br>However, it does look like the tickless support induces UML into a<br>busy loop when NO_HZ is disabled.<br><br>BTW, can you measure C3 time with a before-NO_HZ UML, so we can see<br>that NO_HZ has some sort of benefit on power consumption?
<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Jeff<br><br>--<br>Work email - jdike at linux dot intel dot com<br></blockquote></div><br>

------=_Part_4019_21318122.1193167264169--


--===============0317563900==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============0317563900==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0317563900==--

