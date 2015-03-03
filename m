Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <lorenzo@google.com>) id 1YSiN5-0003pc-SY
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Mar 2015 08:40:07 +0000
Received: from mail-ig0-f182.google.com ([209.85.213.182])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YSiN2-0001js-5O
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Mar 2015 08:40:07 +0000
Received: by igbhn18 with SMTP id hn18so24612781igb.2
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 03 Mar 2015 00:39:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFLxGvzOyRKxQxtCSXePZWiH4SaJKhErKq20Hucx-_=_eXd8aw@mail.gmail.com>
References: <CAKD1Yr31WXUM-s71bUw+N13AmuAaT0cEhNGYp+VyOA1biGg16w@mail.gmail.com>
	<CAFLxGvzOyRKxQxtCSXePZWiH4SaJKhErKq20Hucx-_=_eXd8aw@mail.gmail.com>
From: Lorenzo Colitti <lorenzo@google.com>
Date: Tue, 3 Mar 2015 17:39:38 +0900
Message-ID: <CAKD1Yr2s_KFBv_GZipeeRDY+MkpLkMHahhdkOReqdSQy5ifhLA@mail.gmail.com>
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
Subject: Re: [uml-devel] Warning in syscall_trace_enter
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Erik Kline <ek@google.com>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Tue, Mar 3, 2015 at 5:32 PM, Richard Weinberger
<richard.weinberger@gmail.com> wrote:
> IIRC the big plan is to make tracehook_report_syscall_entry() tree-wide void.

Ack, thanks. In the meantime, for trees we already build with -Werror,
we'll put a temporary local hack in place.

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

