Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Afkaa-0000W6-My for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 11 Jan 2004 10:45:32 -0800
Received: from linuxhacker.ru
	([217.76.32.60] helo=shrek.linuxhacker.ru ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1AfkaZ-0005vE-Rf
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 11 Jan 2004 10:45:32 -0800
From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: [uml-devel] UML running on host-kernel 2.6.0 with NPTL-enabled
	glibc problem
Message-ID: <20040111182804.GF9172@linuxhacker.ru>
References: <3FFE6FE3.8090303@vgertech.com>
	<200401102025.i0AKPXeA004382@car.linuxhacker.ru>
	<200401111149.20507.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401111149.20507.blaisorblade_spam@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 11 Jan 2004 20:28:04 +0200
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Nuno Silva <nuno.silva@vgertech.com>

Hello!

On Sun, Jan 11, 2004 at 11:49:20AM +0100, BlaisorBlade wrote:
> > NS> I've been trying for days and made lots of tests and it seems that the
> > NS> 2.4 UML binary can't run on a host with 2.6 kernel and nptl-enabled
> > glibc.
> > Hm. I guess you are running some sort of old uml code.
> > The fix was oneliner and included long ago. See the patch below.
> > Apply it and then recompile.
> I've just looked at 2.4.23-1um and I saw that dyn_link.ld.in has not this fix. 

Hm. May be someone overlooked possibility to add it there as well?

Bye,
    Oleg


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
