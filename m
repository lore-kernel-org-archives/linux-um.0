Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ahw7U-0003Hj-G6 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Jan 2004 11:28:32 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1Ahw7T-0002C8-Um
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Jan 2004 11:28:32 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: uml-patch-2.6.0
Message-ID: <20040117195019.GA7405@ccure.user-mode-linux.org>
References: <200401130505.i0D55XS4026774@ccure.user-mode-linux.org>
	<87y8sbbrup.fsf@bytesex.org>
	<200401160233.i0G2Xcrf004288@ccure.user-mode-linux.org>
	<200401172009.38339.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401172009.38339.blaisorblade_spam@yahoo.it>
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
Date: Sat, 17 Jan 2004 14:50:19 -0500
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sat, Jan 17, 2004 at 08:09:38PM +0100, BlaisorBlade wrote:
> Do the apply_alternatives + constants silly fix posted 1000 times and compile 
> without CONFIG_MODVERSIONS. Then you don't get the kernel panic, and 
> everything works.
> 
> I've succesfully built kernel with CONFIG_MODVERSIONS, but *maybe* the 
> Makefile patch is needed for that (since files are post-processed with 
> genksyms). However, I have fixed some other things which could interact with 
> this, especially for the link scripts.

Did you actually get modules to work?  I was under the impression you hadn't
got that far yet, just getting UML to build with CONFIG_MODULES endabled.

				Jeff


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
