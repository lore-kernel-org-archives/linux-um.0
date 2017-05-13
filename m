Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1d9Tv5-0003qw-33
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 May 2017 10:05:03 +0000
Received: from mail-oi0-f41.google.com ([209.85.218.41])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1d9Tv4-000492-2I
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 May 2017 10:05:03 +0000
Received: by mail-oi0-f41.google.com with SMTP id b204so89604971oii.1
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 13 May 2017 03:05:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170513101046.Horde.P7MZvg1O0xNi0CnTODsXRIH@webmail.your-server.de>
References: <20170513101046.Horde.P7MZvg1O0xNi0CnTODsXRIH@webmail.your-server.de>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sat, 13 May 2017 12:04:56 +0200
Message-ID: <CAFLxGvyoYQU0e+_pHMZ2k0S3mxNJt9xshN_hrNMAYiTVBLkmMA@mail.gmail.com>
Subject: Re: [uml-devel] userfaultfd for UML userspace processes
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
To: Thomas Meyer <thomas@m3y3r.de>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

Thomas,

On Sat, May 13, 2017 at 10:10 AM, Thomas Meyer <thomas@m3y3r.de> wrote:
>
> Hi,
>
> after looking into using userfaultfd for the userspace UML process
> page fault handling, I come to the conclusion that userfaultfd
> *cannot* be used for above goal as it only operates on mmaped memory
> areas.
> Am I missing something? What do you think about it?

See: https://lkml.org/lkml/2015/5/20/541

-- 
Thanks,
//richard

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

