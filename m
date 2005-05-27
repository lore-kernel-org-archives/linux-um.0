Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DbShJ-0003AZ-KW	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 May 2005 17:27:33 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DbShG-0006UW-Sd	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 May 2005 17:27:33 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 7/7] UML - Remove unused code
References: <200505262230.j4QMUZDf014704@ccure.user-mode-linux.org>
In-Reply-To: <200505262230.j4QMUZDf014704@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505270229.16223.blaisorblade@yahoo.it>
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
Date: Fri, 27 May 2005 02:29:14 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org

On Friday 27 May 2005 00:30, Jeff Dike wrote:
> This removes two now unused files and a couple of unused functions.  The
> files were removed by quilt add $file; rm $file; quilt refresh.  If that
> doesn't do it, I don't know what to do :-)
Be careful with this patch, since from the header timestamp I guess it won't 
remove the file... do it by hand yourself when committing it.

> Signed-off-by: Jeff Dike <jdike@addtoit.com>

> Index: linux-2.6.11/arch/um/kernel/initrd_kern.c
> ===================================================================
> --- linux-2.6.11.orig/arch/um/kernel/initrd_kern.c	2005-05-26
> 17:15:14.000000000 -0400 +++
> linux-2.6.11/arch/um/kernel/initrd_kern.c	2003-09-15 09:40:47.000000000
This should be 1970 to remove the file IIRC.

> Index: linux-2.6.11/arch/um/kernel/initrd_user.c
> ===================================================================
> --- linux-2.6.11.orig/arch/um/kernel/initrd_user.c	2005-05-26
> 17:15:14.000000000 -0400 +++
> linux-2.6.11/arch/um/kernel/initrd_user.c	2003-09-15 09:40:47.000000000
> -0400 @@ -1,46 +0,0 @@
Same for this.

-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.beta.messenger.yahoo.com



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
