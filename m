Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IiBZD-0006tc-Mj for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Oct 2007 09:16:20 -0700
Received: from wa-out-1112.google.com ([209.85.146.177])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IiBZD-0005GD-5s
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Oct 2007 09:16:19 -0700
Received: by wa-out-1112.google.com with SMTP id k22so3193440waf
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 17 Oct 2007 09:16:18 -0700 (PDT)
Message-ID: <1f154f440710170916j4fdb857fw40c9b2fd2b66f63f@mail.gmail.com>
Date: Wed, 17 Oct 2007 12:16:18 -0400
From: Hrishikesh <hrishikesh.amur@gmail.com>
In-Reply-To: <20071017155504.GD9497@c2.user-mode-linux.org>
MIME-Version: 1.0
References: <1f154f440710161936h4800b0c5nb3140ff504212625@mail.gmail.com>
	<20071017155504.GD9497@c2.user-mode-linux.org>
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
Content-Type: multipart/mixed; boundary="===============0762018894=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

--===============0762018894==
Content-Type: multipart/alternative; 
	boundary="----=_Part_44985_26657993.1192637778752"

------=_Part_44985_26657993.1192637778752
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Jeff,
This is when I patch the UML kernel with the NO_HZ patches that you put up
last month.. on 2.6.23-rc6-mm1. Powertop is running on the host kernel and
tells you which process wake up the processor from idle the most and also
which the offending function is (in this case, it shows it to be
do_nanosleep()). Yup this is a bad thing from the power consumption
viewpoint and you would like the processor to be in higher C-states most of
the time.
Regards,
Hrishikesh

On 10/17/07, Jeff Dike <jdike@addtoit.com> wrote:
>
> On Tue, Oct 16, 2007 at 10:36:39PM -0400, Hrishikesh wrote:
> > When running powertop, I notice that there is a dramatic drop in C3
> state
> > residency when running the patched kernel. This happens when you run a
> > patched kernel but without the NO_HZ and HR timers options disabled. C3
> > state residency drops from about 90% to 50% when the UML kernel is idle.
> > This does not happen when the tickless option _is_ enabled.
>
> Which kernel is the patched kernel, the host or UML?
>
> Whichever kernel this is, I take it that this is a bad thing?
>
>                                 Jeff
>
> --
> Work email - jdike at linux dot intel dot com
>

------=_Part_44985_26657993.1192637778752
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Jeff,<br>This is when I patch the UML kernel with the NO_HZ patches that you put up last month.. on 2.6.23-rc6-mm1. Powertop is running on the host kernel and tells you which process wake up the processor from idle the most and also which the offending function is (in this case, it shows it to be do_nanosleep()). Yup this is a bad thing from the power consumption viewpoint and you would like the processor to be in higher C-states most of the time. 
<br>Regards,<br>Hrishikesh<br><br><div><span class="gmail_quote">On 10/17/07, <b class="gmail_sendername">Jeff Dike</b> &lt;<a href="mailto:jdike@addtoit.com">jdike@addtoit.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Tue, Oct 16, 2007 at 10:36:39PM -0400, Hrishikesh wrote:<br>&gt; When running powertop, I notice that there is a dramatic drop in C3 state<br>&gt; residency when running the patched kernel. This happens when you run a<br>
&gt; patched kernel but without the NO_HZ and HR timers options disabled. C3<br>&gt; state residency drops from about 90% to 50% when the UML kernel is idle.<br>&gt; This does not happen when the tickless option _is_ enabled.
<br><br>Which kernel is the patched kernel, the host or UML?<br><br>Whichever kernel this is, I take it that this is a bad thing?<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Jeff<br><br>--<br>Work email - jdike at linux dot intel dot com
<br></blockquote></div><br>

------=_Part_44985_26657993.1192637778752--


--===============0762018894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============0762018894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0762018894==--

