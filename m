Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EMAPf-00075f-G3	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 02 Oct 2005 13:26:23 -0700
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EM2AX-0003BC-CM
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 02 Oct 2005 04:38:14 -0700
From: Al Viro <viro@ftp.linux.org.uk>
Message-ID: <20051002113806.GO7992@ftp.linux.org.uk>
References: <200510021213.40191.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510021213.40191.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: UML/2.6.14-rc3 doesn't work fixes
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
Date: Sun, 2 Oct 2005 12:38:06 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, Alexander Viro <viro@zeniv.linux.org.uk>

On Sun, Oct 02, 2005 at 12:13:39PM +0200, Blaisorblade wrote:
> The patch in Al Viro's:
> 
> ecba97d4aacf4e80c56eb73e39af0369cb8539a4
> 
> messed up UML (in particular skas0, which doesn't boot any more - or maybe it 
> boots one out of 10 times).
> 
> Btw: did Al CC you on it, at least?

Yes.  Moreover, that had also been done two weeks ago when original version
of patch had been sent for review to Jeff.  Who'd caught that one and other
bugs and sent the fixed variant back.   At which point I'd fscked up the
merge.


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
