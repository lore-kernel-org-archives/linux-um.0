Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1XgFc0-00032P-8p
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Oct 2014 16:15:12 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XgFby-0005qt-2H
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Oct 2014 16:15:12 +0000
References: <E1XgAye-0000BK-Rd@www17.your-server.de>
	<CAFLxGvxCWPrC1w-DWn6chseG=HcZ1jg7Sa0gUodmOYu05wrJKQ@mail.gmail.com>
In-Reply-To: <CAFLxGvxCWPrC1w-DWn6chseG=HcZ1jg7Sa0gUodmOYu05wrJKQ@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1085)
Message-Id: <4CA477DE-7D40-4685-8737-142D0A81C3DF@m3y3r.de>
From: Thomas Meyer <thomas@m3y3r.de>
Date: Mon, 20 Oct 2014 18:14:51 +0200
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
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Daniel Walter <sahne@0x90.at>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>


Am 20.10.2014 um 14:13 schrieb Richard Weinberger:

> On Mon, Oct 20, 2014 at 1:18 PM, Thomas Meyer <thomas@m3y3r.de> wrote:
>> Am 20.10.2014 11:28 schrieb Daniel Walter <sahne@0x90.at>:
>>> 
>>> ----- Original Message -----
>>>> From: "Thomas Meyer" <thomas@m3y3r.de>
>>>> To: "user-mode-linux-devel" <user-mode-linux-devel@lists.sourceforge.net>
>>>> Sent: Sunday, October 19, 2014 4:14:13 PM
>>>> Subject: [uml-devel] [PATCH v3 3/3] um: enable trace irqflags support
>>>> 
>>>> Add TRACE_IRQFLAGS_SUPPORT to UML.
>>>> This enables LOCKDEP_SUPPORT and TRACING_SUPPORT.
>>> 
>>> 
>>> FYI: I'm currently working on porting ftrace() support to
>>> uml. It will take another week or two since I don't have enough
>>> time to debug, and it isn't stable yet (read as is panic()ing randomly)
>> 
>> Good to know :-)
>> 
>> Thanks for you stack trace support work!
>> 
>> BTW. When triggering a sysrq t with the uml console the stack trace is not displayed, it says that the stack trace failed because a sigsegv happens in the stack trace or something like that. Bug or feature?
> 
> Huh? More details please. uml_mconsole's sysrq t works fine here with
> both x86 and x86_86 uml.
Hi,

sorry about the fuss. everything seems to work correctly.

Maybe I did see this while doing some testing with some fixes.

sorry.

> 
> -- 
> Thanks,
> //richard


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

