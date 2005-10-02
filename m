Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EMCVw-00039E-W3	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 02 Oct 2005 15:41:01 -0700
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EM2Mi-0004m0-LZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 02 Oct 2005 04:50:51 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
References: <200510021213.40191.blaisorblade@yahoo.it>
	<20051002113806.GO7992@ftp.linux.org.uk>
In-Reply-To: <20051002113806.GO7992@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510021350.29959.blaisorblade@yahoo.it>
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
Date: Sun, 2 Oct 2005 13:50:28 +0200
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, Alexander Viro <viro@zeniv.linux.org.uk>

On Sunday 02 October 2005 13:38, Al Viro wrote:
> On Sun, Oct 02, 2005 at 12:13:39PM +0200, Blaisorblade wrote:
> > The patch in Al Viro's:

> > ecba97d4aacf4e80c56eb73e39af0369cb8539a4

> > messed up UML (in particular skas0, which doesn't boot any more - or
> > maybe it boots one out of 10 times).

> > Btw: did Al CC you on it, at least?

> Yes.  Moreover, that had also been done two weeks ago when original version
> of patch had been sent for review to Jeff.  Who'd caught that one and other
> bugs and sent the fixed variant back.   At which point I'd fscked up the
> merge.

Ok, you're excused... now, however, I still think that this should be 
postponed to 2.6.15, since it's a (very nice, indeed) cleanup and we're 
nearing completion.

Al, did you receive my "[PATCH 5/5] uml: remove empty hostfs_truncate method"? 
What about that? I'm nervous because the whole batch was lost somewhere 
without merging, it seems (and it has a couple of other critical fixes).
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
