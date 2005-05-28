Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DbzU4-0002sc-26	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 28 May 2005 04:28:04 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DbzU3-00072q-CN	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 28 May 2005 04:28:03 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 3/7] UML - Turn off kmalloc always on a fatal
	signal
References: <200505262230.j4QMUQ5m014682@ccure.user-mode-linux.org>
	<Pine.LNX.4.58.0505261812230.1625@gradall.private.brainfood.com>
	<20050527011648.GA16539@ccure.user-mode-linux.org>
In-Reply-To: <20050527011648.GA16539@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505281330.05885.blaisorblade@yahoo.it>
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
Date: Sat, 28 May 2005 13:30:05 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Adam Heath <doogie@debian.org>, akpm@osdl.org

On Friday 27 May 2005 03:16, Jeff Dike wrote:
> On Thu, May 26, 2005 at 06:13:02PM -0500, Adam Heath wrote:
> > This and some of the other patches are changing the formatting.  The new
> > line above is using spaces instead of a tab.
>
> On purpose - I'm making UML more CodingStyle conformant, and doing it as
> I'm modifying stuff anyway.  The alternative is a set of whitespace
> patches, which will gratuitously make a barrier across which patches need
> to be hand-merged.
Yes but CodingStyle recommends tabs:

"Outside of comments, documentation and except in Kconfig, spaces are never
used for indentation, and the above example is deliberately broken."

-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
