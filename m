Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C7Cvp-0003y3-1W for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Sep 2004 06:01:13 -0700
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1C7Cvn-0007k6-DU
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Sep 2004 06:01:12 -0700
From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [uml-devel] Re: [ann] kraxel's 2.6.8 uml patch kit
Message-ID: <20040914123658.GB29562@bytesex>
References: <20040820122445.GA21790@bytesex>
	<200408201901.i7KJ1eIF003843@ccure.user-mode-linux.org>
	<20040822111745.GA10736@bytesex> <4133C57D.6060201@enterasys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4133C57D.6060201@enterasys.com>
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
Date: Tue, 14 Sep 2004 14:36:58 +0200
To: "D. Bahi" <dbahi@enterasys.com>
Cc: Jeff Dike <jdike@addtoit.com>, uml devel <user-mode-linux-devel@lists.sourceforge.net>

> I liked this too. Here's a pass at it if you like (attached).

Sorry for the delay, going over this while being busy updating my
patches right now ...

> +static int panic_coreonpanic(struct notifier_block *self, unsigned long unused1,
> +			     void *unused2)
> +{
> +	if(uml_coreonpanic){
> +		uml_cleanup();
> +		block_signals();
> +		abort();

What is the point of doing that?  I'd just let it dump core without any
cleanups, to get the state of the uml kernel dumped to the disk with few
modifications as possible.  Any changes might make the analysis of the
crash harder or even impossible.

  Gerd

-- 
return -ENOSIG;


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
