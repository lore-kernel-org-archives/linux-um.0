Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1YSivd-0007q0-V0
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Mar 2015 09:15:49 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YSivb-0001h2-U7
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Mar 2015 09:15:49 +0000
Message-ID: <54F57579.9@nod.at>
Date: Tue, 03 Mar 2015 09:48:57 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <CAKD1Yr31WXUM-s71bUw+N13AmuAaT0cEhNGYp+VyOA1biGg16w@mail.gmail.com>
	<CAFLxGvzOyRKxQxtCSXePZWiH4SaJKhErKq20Hucx-_=_eXd8aw@mail.gmail.com>
	<CAKD1Yr2s_KFBv_GZipeeRDY+MkpLkMHahhdkOReqdSQy5ifhLA@mail.gmail.com>
In-Reply-To: <CAKD1Yr2s_KFBv_GZipeeRDY+MkpLkMHahhdkOReqdSQy5ifhLA@mail.gmail.com>
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
To: Lorenzo Colitti <lorenzo@google.com>
Cc: Erik Kline <ek@google.com>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

Am 03.03.2015 um 09:39 schrieb Lorenzo Colitti:
> On Tue, Mar 3, 2015 at 5:32 PM, Richard Weinberger
> <richard.weinberger@gmail.com> wrote:
>> IIRC the big plan is to make tracehook_report_syscall_entry() tree-wide void.
> 
> Ack, thanks. In the meantime, for trees we already build with -Werror,
> we'll put a temporary local hack in place.

As long GCC has a shitload of completely useless warnings building with -Werror
is just a PITA. That's why Linux does not use that flag. :-)

Thanks,
//richard

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

