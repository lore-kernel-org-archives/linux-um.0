Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IkTYV-00088T-CK for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Oct 2007 16:53:03 -0700
Received: from rv-out-0910.google.com ([209.85.198.189])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IkTYT-0002VT-W3
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Oct 2007 16:53:03 -0700
Received: by rv-out-0910.google.com with SMTP id g11so82975rvb
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 23 Oct 2007 16:53:01 -0700 (PDT)
Message-ID: <1f154f440710231653s69d02dbepc552c5fe8d7f2b3f@mail.gmail.com>
Date: Tue, 23 Oct 2007 19:53:01 -0400
From: Hrishikesh <hrishikesh.amur@gmail.com>
In-Reply-To: <20071023213545.GA11026@c2.user-mode-linux.org>
MIME-Version: 1.0
References: <1f154f440710161936h4800b0c5nb3140ff504212625@mail.gmail.com>
	<20071017155504.GD9497@c2.user-mode-linux.org>
	<1f154f440710170916j4fdb857fw40c9b2fd2b66f63f@mail.gmail.com>
	<20071017171920.GA10388@c2.user-mode-linux.org>
	<1f154f440710171243x40898f8bq386c91c59789fb42@mail.gmail.com>
	<20071017204527.GB12812@c2.user-mode-linux.org>
	<1f154f440710171629meb5a3ces92b8fdeacc371857@mail.gmail.com>
	<20071018200432.GA9204@c2.user-mode-linux.org>
	<1f154f440710231221r76d63ec2h640e95c7afa05a6a@mail.gmail.com>
	<20071023213545.GA11026@c2.user-mode-linux.org>
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
Content-Type: multipart/mixed; boundary="===============0342449029=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

--===============0342449029==
Content-Type: multipart/alternative; 
	boundary="----=_Part_5197_30321795.1193183581596"

------=_Part_5197_30321795.1193183581596
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 10/23/07, Jeff Dike <jdike@addtoit.com> wrote:
>
> On Tue, Oct 23, 2007 at 04:21:03PM -0300, Hrishikesh wrote:
> >> Yes, that double negative was a slipup. I did get some numbers out and
> they
> >> look pretty good. I ran upto 5 instances of UML simultaneously and in
> the
> >> tickful case, each instance adds roughly about 100 wakeups per second.
>
> > HZ == 100, so that makes sense.


>> So
> >> after 5 instances, C3 residency comes down to about 95% when all the
> >> instances are simply idling. With NO_HZ applied, the change is minimal
> with
> >> C3 residency still approximately 98%. UML is not even among the top
> three of
> >> the bad-list of wakers-up :-)
>
> > Cool.  I'm suprised that 500 wakeups/sec only brings you down < 5%.


Hmm,  powertop shows  500 wakeups  on  part of UML, but the actual number of
wakeups for the processor is much  lesser..  Guess there is  some  batching
that  is happening.

> So, things are good, except I need to figure out the !NO_HZ busy loop.
> >
> >                                Jeff
> >
> > --
> > Work email - jdike at linux dot intel dot com


Hrishi

------=_Part_5197_30321795.1193183581596
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">On 10/23/07, <b class="gmail_sendername">Jeff Dike</b> &lt;<a href="mailto:jdike@addtoit.com">jdike@addtoit.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Tue, Oct 23, 2007 at 04:21:03PM -0300, Hrishikesh wrote:<br>&gt;&gt; Yes, that double negative was a slipup. I did get some numbers out and they<br>&gt;&gt; look pretty good. I ran upto 5 instances of UML simultaneously and in the
<br>&gt;&gt; tickful case, each instance adds roughly about 100 wakeups per second.<br><br>&gt; HZ == 100, so that makes sense.&nbsp;</blockquote><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
&gt;&gt; So<br>&gt;&gt; after 5 instances, C3 residency comes down to about 95% when all the<br>&gt;&gt; instances are simply idling. With NO_HZ applied, the change is minimal with<br>&gt;&gt; C3 residency still approximately 98%. UML is not even among the top three of
<br>&gt;&gt; the bad-list of wakers-up :-)<br><br>&gt; Cool.&nbsp;&nbsp;I&#39;m suprised that 500 wakeups/sec only brings you down &lt; 5%.</blockquote><div><br>Hmm,&nbsp; powertop shows&nbsp; 500 wakeups&nbsp; on&nbsp; part of UML, but the actual number of wakeups for the processor is much&nbsp; lesser..&nbsp; Guess there is&nbsp; some&nbsp; batching that&nbsp; is happening. 
<br></div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; So, things are good, except I need to figure out the !NO_HZ busy loop.<br>
&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Jeff<br>&gt;<br>&gt; --<br>&gt; Work email - jdike at linux dot intel dot com</blockquote><div><br>Hrishi <br></div><br></div><br>

------=_Part_5197_30321795.1193183581596--


--===============0342449029==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============0342449029==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0342449029==--

