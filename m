Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQ89q-0003dL-SZ for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 May 2004 10:13:38 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1BQ89q-0004hk-6F
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 May 2004 10:13:38 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] [PATCH] host context switch reduction
Message-ID: <20040518175904.GB29114@ccure.user-mode-linux.org>
References: <20040229043549.GA8583@ccure.user-mode-linux.org>
	<02dc01c43c4a$bb7c0490$2000000a@schlepptopp>
	<1084831251.1230.4.camel@chartreuse>
	<03ff01c43c5d$7db6e5e0$2000000a@schlepptopp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03ff01c43c5d$7db6e5e0$2000000a@schlepptopp>
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
Date: Tue, 18 May 2004 13:59:04 -0400
To: roland <for_spam@gmx.de>
Cc: Laurent Vivier <LaurentVivier@wanadoo.fr>, user-mode-linux-devel@lists.sourceforge.net

On Tue, May 18, 2004 at 12:22:45AM +0200, roland wrote:
> the question is:
> is the "real world" performance benefit, uml get`s from this patch worth taking your time and is it implemented in a way, so that
> uml maintainers are happy with that ?

The patch seems reasonable to me.  I'd be happiest with Laurent pushing this
into mainline himself.

> i cannot really estimate, what performance benefits your patch brings to uml in detail, but what i have seen so far, this seems
> quite worth doing the work.  reducing context switches by 1/3 is a LOT, imho - and reducing the execution time of the getpid-loop to
> nearly the half is quite impressive.

Yeah, but no real workloads do while(1) getpid();

The kernel build improvement is obviously smaller, but still worth having.

> are there any "con`s" that argue for that work _NOT_ being done ?

No.  But testing, and happy reports to the appropriate mailing lists would
help.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
