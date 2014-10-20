Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1XgBq7-0001JV-Tt
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Oct 2014 12:13:31 +0000
Received: from mail-vc0-f169.google.com ([209.85.220.169])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1XgBq6-0002xm-6R
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Oct 2014 12:13:31 +0000
Received: by mail-vc0-f169.google.com with SMTP id hy4so3437378vcb.28
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 20 Oct 2014 05:13:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <E1XgAye-0000BK-Rd@www17.your-server.de>
References: <E1XgAye-0000BK-Rd@www17.your-server.de>
Date: Mon, 20 Oct 2014 14:13:24 +0200
Message-ID: <CAFLxGvxCWPrC1w-DWn6chseG=HcZ1jg7Sa0gUodmOYu05wrJKQ@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH v3 3/3] um: enable trace irqflags support
To: Thomas Meyer <thomas@m3y3r.de>
Cc: Daniel Walter <sahne@0x90.at>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

On Mon, Oct 20, 2014 at 1:18 PM, Thomas Meyer <thomas@m3y3r.de> wrote:
> Am 20.10.2014 11:28 schrieb Daniel Walter <sahne@0x90.at>:
>>
>> ----- Original Message -----
>> > From: "Thomas Meyer" <thomas@m3y3r.de>
>> > To: "user-mode-linux-devel" <user-mode-linux-devel@lists.sourceforge.net>
>> > Sent: Sunday, October 19, 2014 4:14:13 PM
>> > Subject: [uml-devel] [PATCH v3 3/3] um: enable trace irqflags support
>> >
>> > Add TRACE_IRQFLAGS_SUPPORT to UML.
>> > This enables LOCKDEP_SUPPORT and TRACING_SUPPORT.
>>
>>
>> FYI: I'm currently working on porting ftrace() support to
>> uml. It will take another week or two since I don't have enough
>> time to debug, and it isn't stable yet (read as is panic()ing randomly)
>
> Good to know :-)
>
> Thanks for you stack trace support work!
>
> BTW. When triggering a sysrq t with the uml console the stack trace is not displayed, it says that the stack trace failed because a sigsegv happens in the stack trace or something like that. Bug or feature?

Huh? More details please. uml_mconsole's sysrq t works fine here with
both x86 and x86_86 uml.

-- 
Thanks,
//richard

------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

