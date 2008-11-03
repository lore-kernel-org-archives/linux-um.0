Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <roman.yepishev@gmail.com>) id 1Kx7FE-00006u-09
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Nov 2008 21:45:56 +0000
Received: from el-out-1112.google.com ([209.85.162.177])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Kx7FC-0002nG-Hs for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Nov 2008 21:45:55 +0000
Received: by el-out-1112.google.com with SMTP id z25so1305518ele.1
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 03 Nov 2008 13:45:53 -0800 (PST)
Message-ID: <f39be10d0811031335me028b1dhed153cdbb956250@mail.gmail.com>
Date: Mon, 3 Nov 2008 23:35:52 +0200
From: "Roman Yepishev" <roman.yepishev@gmail.com>
In-Reply-To: <20081031191452.GA10950@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
References: <f39be10d0810241608i590d13f5p429c02558a1c26cf@mail.gmail.com>
	<20081031191452.GA10950@c2.user-mode-linux.org>
Subject: Re: [uml-devel] UML crashes when built with _FORTIFY_SOURCE
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
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, Oct 31, 2008 at 9:14 PM, Jeff Dike <jdike@addtoit.com> wrote:
> On Sat, Oct 25, 2008 at 02:08:31AM +0300, Roman Yepishev wrote:
>> Temporary solution is to fix file declaration to be 108 or less bytes
>> but checks should be introduced when socket path is constructed.
>
> I don't really understand what you mean by checks being introduced,
> but how do you like the patch below?
>
>                        Jeff
>
> --
> Work email - jdike at linux dot intel dot com
>
[patch skipped]

Looks great, checked on i386 system - successfully builds and runs
with _FORTIFY_SOURCE.

By "checks" i meant the case when uml_dir  and/or  umid is too long to be used.
Currently the execution continues with a humble message

 NET: Registered protocol family 1
>umid_file_name : buffer too short
 Checking host MADV_REMOVE support...OK
 Host TLS support detected

I guess this case should be documented somehow as well.

-- 
Regards,
Roman Yepishev

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
