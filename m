Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1dTPtA-0006z1-EQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Jul 2017 09:49:28 +0000
Received: from mail-oi0-f42.google.com ([209.85.218.42])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1dTPt9-0005bA-Ho
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Jul 2017 09:49:28 +0000
Received: by mail-oi0-f42.google.com with SMTP id l130so23501817oib.1
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 07 Jul 2017 02:49:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFLxGvy9LdJaC563QntMfErGkzoJVojp70iDKqk-zwj3SCf8kw@mail.gmail.com>
References: <20170706210404.18253-1-thomas@m3y3r.de>
	<CAFLxGvy9LdJaC563QntMfErGkzoJVojp70iDKqk-zwj3SCf8kw@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Fri, 7 Jul 2017 11:49:21 +0200
Message-ID: <CAFLxGvzZ6u4ARATp01JzX-Pb58-f_9TdWV5K1Da12GVHEY5Ogg@mail.gmail.com>
Subject: Re: [uml-devel] [PATCH] um: Fix FP register size for XSTATE/XSAVE
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>,
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

On Fri, Jul 7, 2017 at 11:26 AM, Richard Weinberger
<richard.weinberger@gmail.com> wrote:
> On Thu, Jul 6, 2017 at 11:04 PM, Thomas Meyer <thomas@m3y3r.de> wrote:
>> Hard code max size. Taken from
>> https://sourceware.org/git/?p=binutils-gdb.git;a=blob;f=gdb/common/x86-xstate.h
>>
>> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
>> ---
>>  arch/x86/um/os-Linux/registers.c | 9 ++++-----
>>  arch/x86/um/user-offsets.c       | 2 +-
>>  2 files changed, 5 insertions(+), 6 deletions(-)
>
> Applied. Thanks a lot for taking care of this nasty issue!

Erm, did you notice the scary compiler warning produced by this commit? :-(

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

