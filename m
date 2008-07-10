Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KGlqn-0004gf-H0 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Jul 2008 19:25:41 -0700
Received: from smtp-out.google.com ([216.239.33.17])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KGlql-0003ru-A9
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Jul 2008 19:25:41 -0700
Received: from spaceape10.eur.corp.google.com (spaceape10.eur.corp.google.com
	[172.28.16.144]) by smtp-out.google.com with ESMTP id m6A2PU5L016804
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 10 Jul 2008 03:25:30 +0100
Received: from rv-out-0708.google.com (rvfc5.prod.google.com [10.140.180.5])
	by spaceape10.eur.corp.google.com with ESMTP id m6A2PEtS022985
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 10 Jul 2008 03:25:29 +0100
Received: by rv-out-0708.google.com with SMTP id c5so2944944rvf.16
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 09 Jul 2008 19:25:29 -0700 (PDT)
Message-ID: <5df78e1d0807091925q64c0121fk3d33c37df8d80d18@mail.gmail.com>
Date: Thu, 10 Jul 2008 10:25:29 +0800
From: "Jiaying Zhang" <jiayingz@google.com>
In-Reply-To: <5df78e1d0807031806s74c13c84idadc62c1d1e0e93b@mail.gmail.com>
MIME-Version: 1.0
References: <5df78e1d0807030053x8a9bfabo582ea78e74b2c65b@mail.gmail.com>
	<20080703135639.GA8262@c2.user-mode-linux.org>
	<5df78e1d0807031806s74c13c84idadc62c1d1e0e93b@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============0311990706=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

--===============0311990706==
Content-Type: multipart/alternative; 
	boundary="----=_Part_8212_29200533.1215656729084"

------=_Part_8212_29200533.1215656729084
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Jeff,

Do you have any thought about what the problem might be?
Thanks a lot!

Jiaying

On Fri, Jul 4, 2008 at 9:06 AM, Jiaying Zhang <jiayingz@google.com> wrote:

> The stack trace isn't very helpful. Here it is.
>
> EIP: 0073:[<d84156c5>] CPU: 0 Not tainted ESP: 007b:0be3ea78 EFLAGS:
> 00210206
>     Not tainted
> EAX: 0be548d8 EBX: 08325b54 ECX: 08325b58 EDX: 0be548cc
> ESI: 00000001 EDI: 080598c6 EBP: 0be3ea98 DS: 007b ES: 007b
> 08323b6c:  [<0806a718>] show_regs+0xc4/0xc9
> 08323b98:  [<080594b3>] segv+0x20e/0x226
> 08323c3c:  [<080592a0>] segv_handler+0x4f/0x54
> 08323c5c:  [<0806537b>] sig_handler_common+0x63/0x72
> 08323cd4:  [<080653b8>] sig_handler+0x2e/0x3e
> 08323cec:  [<080654dd>] handle_signal+0x4d/0x7a
> 08323d0c:  [<08066ebf>] hard_handler+0xf/0x14
> 08323d1c:  [<b7fff420>] 0xb7fff420
>
> Kernel panic - not syncing: Kernel mode fault at addr 0xd84156c5, ip
> 0xd84156c5
>
> EIP: 0073:[<40146334>] CPU: 0 Not tainted ESP: 007b:bfaf2378 EFLAGS:
> 00200246
>     Not tainted
> EAX: ffffffda EBX: 00000003 ECX: c134fd09 EDX: 08050368
> ESI: 4002b7c0 EDI: 40029180 EBP: bfaf24c8 DS: 007b ES: 007b
> 08323ad8:  [<0806a718>] show_regs+0xc4/0xc9
> 08323b04:  [<080596ed>] panic_exit+0x23/0x39
> 08323b18:  [<080849d0>] notifier_call_chain+0x21/0x4d
> 08323b38:  [<08084a72>] __atomic_notifier_call_chain+0x17/0x19
> 08323b54:  [<08084a89>] atomic_notifier_call_chain+0x15/0x17
> 08323b70:  [<0807116f>] panic+0x4f/0xd1
> 08323b8c:  [<080594c1>] segv+0x21c/0x226
> 08323c3c:  [<080592a0>] segv_handler+0x4f/0x54
> 08323c5c:  [<0806537b>] sig_handler_common+0x63/0x72
> 08323cd4:  [<080653b8>] sig_handler+0x2e/0x3e
> 08323cec:  [<080654dd>] handle_signal+0x4d/0x7a
> 08323d0c:  [<08066ebf>] hard_handler+0xf/0x14
> 08323d1c:  [<b7fff420>] 0xb7fff420
>
> Segmentation fault
>
> Jiaying
>
>
> On Thu, Jul 3, 2008 at 9:56 PM, Jeff Dike <jdike@addtoit.com> wrote:
>
>> On Thu, Jul 03, 2008 at 12:53:46AM -0700, Jiaying Zhang wrote:
>> > I found since 2.6.25 kernels, uml crashes when it calls down() on a
>> > semaphore with
>> > zero counter.
>>
>> What's the stack trace?
>>
>> Can you bisect it?
>>
>>                Jeff
>>
>> --
>> Work email - jdike at linux dot intel dot com
>>
>
>

------=_Part_8212_29200533.1215656729084
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Jeff,<br><br>Do you have any thought about what the problem might be?<br>Thanks a lot!<br><br>Jiaying<br><br><div class="gmail_quote">On Fri, Jul 4, 2008 at 9:06 AM, Jiaying Zhang &lt;<a href="mailto:jiayingz@google.com">jiayingz@google.com</a>&gt; wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">The stack trace isn&#39;t very helpful. Here it is.<br><br>EIP: 0073:[&lt;d84156c5&gt;] CPU: 0 Not tainted ESP: 007b:0be3ea78 EFLAGS: 00210206<br>
&nbsp;&nbsp;&nbsp; Not tainted<br>EAX: 0be548d8 EBX: 08325b54 ECX: 08325b58 EDX: 0be548cc<br>
ESI: 00000001 EDI: 080598c6 EBP: 0be3ea98 DS: 007b ES: 007b<br>08323b6c:&nbsp; [&lt;0806a718&gt;] show_regs+0xc4/0xc9<br>08323b98:&nbsp; [&lt;080594b3&gt;] segv+0x20e/0x226<br>08323c3c:&nbsp; [&lt;080592a0&gt;] segv_handler+0x4f/0x54<br>

08323c5c:&nbsp; [&lt;0806537b&gt;] sig_handler_common+0x63/0x72<br>08323cd4:&nbsp; [&lt;080653b8&gt;] sig_handler+0x2e/0x3e<br>08323cec:&nbsp; [&lt;080654dd&gt;] handle_signal+0x4d/0x7a<br>08323d0c:&nbsp; [&lt;08066ebf&gt;] hard_handler+0xf/0x14<br>

08323d1c:&nbsp; [&lt;b7fff420&gt;] 0xb7fff420<br><br>Kernel panic - not syncing: Kernel mode fault at addr 0xd84156c5, ip 0xd84156c5<br><br>EIP: 0073:[&lt;40146334&gt;] CPU: 0 Not tainted ESP: 007b:bfaf2378 EFLAGS: 00200246<br>

&nbsp;&nbsp;&nbsp; Not tainted<br>EAX: ffffffda EBX: 00000003 ECX: c134fd09 EDX: 08050368<br>ESI: 4002b7c0 EDI: 40029180 EBP: bfaf24c8 DS: 007b ES: 007b<br>08323ad8:&nbsp; [&lt;0806a718&gt;] show_regs+0xc4/0xc9<br>08323b04:&nbsp; [&lt;080596ed&gt;] panic_exit+0x23/0x39<br>

08323b18:&nbsp; [&lt;080849d0&gt;] notifier_call_chain+0x21/0x4d<br>08323b38:&nbsp; [&lt;08084a72&gt;] __atomic_notifier_call_chain+0x17/0x19<br>08323b54:&nbsp; [&lt;08084a89&gt;] atomic_notifier_call_chain+0x15/0x17<br>08323b70:&nbsp; [&lt;0807116f&gt;] panic+0x4f/0xd1<br>

08323b8c:&nbsp; [&lt;080594c1&gt;] segv+0x21c/0x226<br>08323c3c:&nbsp; [&lt;080592a0&gt;] segv_handler+0x4f/0x54<br>08323c5c:&nbsp; [&lt;0806537b&gt;] sig_handler_common+0x63/0x72<br>08323cd4:&nbsp; [&lt;080653b8&gt;] sig_handler+0x2e/0x3e<br>

08323cec:&nbsp; [&lt;080654dd&gt;] handle_signal+0x4d/0x7a<br>08323d0c:&nbsp; [&lt;08066ebf&gt;] hard_handler+0xf/0x14<br>08323d1c:&nbsp; [&lt;b7fff420&gt;] 0xb7fff420<br><br>Segmentation fault<br><font color="#888888"><br>Jiaying</font><div>
<div></div><div class="Wj3C7c"><br><br><div class="gmail_quote">
On Thu, Jul 3, 2008 at 9:56 PM, Jeff Dike &lt;<a href="mailto:jdike@addtoit.com" target="_blank">jdike@addtoit.com</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

<div>On Thu, Jul 03, 2008 at 12:53:46AM -0700, Jiaying Zhang wrote:<br>
&gt; I found since 2.6.25 kernels, uml crashes when it calls down() on a<br>
&gt; semaphore with<br>
&gt; zero counter.<br>
<br>
</div>What&#39;s the stack trace?<br>
<br>
Can you bisect it?<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Jeff<br>
<font color="#888888"><br>
--<br>
Work email - jdike at linux dot intel dot com<br>
</font></blockquote></div><br>
</div></div></blockquote></div><br>

------=_Part_8212_29200533.1215656729084--


--===============0311990706==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
--===============0311990706==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0311990706==--

