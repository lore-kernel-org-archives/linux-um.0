Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AsnLb-0006su-A1
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 16 Feb 2004 10:19:59 -0800
Received: from web41302.mail.yahoo.com ([66.218.93.51])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AsnCN-0003z6-Pr
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 16 Feb 2004 10:10:27 -0800
Message-ID: <20040216181607.73452.qmail@web41302.mail.yahoo.com>
From: Christopher Olson <christopher_sf@yahoo.com>
Subject: Re: [uml-devel] Kernel idles in loop after loading IPv4
In-Reply-To: <1076950110.2286.20.camel@rocket.innercite.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 16 Feb 2004 10:16:07 -0800 (PST)
To: user-mode-linux-devel@lists.sourceforge.net

I started from Fedora Core 1, which I upgraded to a
2.6.1 kernel the skas3.  I also suspected NPTL was
causing the troubles, so I tried moving /lib/tls to
/lib/tls.off and still got the hang.  I also tried
rebuilding glibc-2.3.2 with linux threads, then
building and running UML against that, but I still got
the hang.

I obtained the skas3 patch from sdw.st.  Alegedly, it
has problems, but it was the only skas3 patch I could
apply to 2.6.1 cleanly.

Chris.

--- Phil Nadeau <phil@innercite.com> wrote:

> Based on other things I've seen on the list, I
> suspect it's an issue
> with the host using NPTL. This occurs with 2.4.22
> Fedora Core kernels
> and vanilla 2.6.0 and 2.6.1 kernels compiled with
> and without SKAS.
> Since NPTL seems to be a Known Issue, I was leaving
> it alone for now.
> Any other ideas?





__________________________________
Do you Yahoo!?
Yahoo! Finance: Get your refund fast by filing online.
http://taxes.yahoo.com/filing.html


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
