Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FeD7M-0001wh-3p for User-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 May 2006 08:30:20 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FeD7K-00055Y-L6
	for User-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 May 2006 08:30:20 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] SecurityFocus Article
Message-ID: <20060511153007.GA3472@ccure.user-mode-linux.org>
References: <20060511144508.25147.qmail@securityfocus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060511144508.25147.qmail@securityfocus.com>
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
Date: Thu, 11 May 2006 11:30:07 -0400
To: Ed White <ed.white@libero.it>
Cc: ML <User-mode-linux-devel@lists.sourceforge.net>

On Thu, May 11, 2006 at 02:45:08PM -0000, Ed White wrote:
> I would like to know if UML barriers could by bypassed using this
> attack, or not. Maybe we will need a patch for the kernel, or for UML,
> or what? 

I don't see an actual attack.  The article is assuming some
unspecified vulnerability in the X server.

That being said, UML instances (and processes inside them) typically
have no access to the host's X server, so I can't see this being used
to break out of a UML.

If the host X server accepts connections from remote machines, and has
a vulnerability that can be exploited remotely, then a UML can connect
to it and use it to break out.  However, I would regard this as being
a generic remote exploit that a UML happens to be able to use rather
than something specific to UML.

In this case, as with other remote exploits, the fix is on the host
rather than in the UML.

				Jeff


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
