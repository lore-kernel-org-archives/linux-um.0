Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ai4Yw-000722-6a for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Jan 2004 20:29:26 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1Ai4Yv-00059M-Kv
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Jan 2004 20:29:25 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: uml-patch-2.6.0
Message-ID: <20040118045121.GD8571@ccure.user-mode-linux.org>
References: <200401130505.i0D55XS4026774@ccure.user-mode-linux.org>
	<200401172009.38339.blaisorblade_spam@yahoo.it>
	<20040117195019.GA7405@ccure.user-mode-linux.org>
	<200401172103.26457.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401172103.26457.blaisorblade_spam@yahoo.it>
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
Date: Sat, 17 Jan 2004 23:51:21 -0500
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sat, Jan 17, 2004 at 09:03:26PM +0100, BlaisorBlade wrote:
> I didn't start it. Also, I must check exactly the API to create (i.e. how to 
> abstract os-specific details, which is hard since I've never programmed on 
> Cygwin or Freebsd). And also, if you assume that a file handle is an integer 
> (which is true only on POSIX), why do you wrap open inside os_open_file 
> (which always works on POSIX)? The same question could go for other calls.

I don't, but I'm leaving it as an int for now since that works.  The interfaces
can be tweaked in the future, so a descriptor may become some sort of void *
cookie to handle OSes with non-integer file handles.

What I'm trying to do now is get some sort of reasonable approximation to
a decent OS abstraction layer.

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
