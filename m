Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KQ3PR-00033f-DM for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Aug 2008 09:59:49 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KQ3PP-0000cI-KA
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Aug 2008 09:59:49 -0700
Date: Mon, 4 Aug 2008 12:58:38 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080804165838.GH14805@c2.user-mode-linux.org>
References: <488DD82A.1020606@lipn.univ-paris13.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <488DD82A.1020606@lipn.univ-paris13.fr>
Subject: Re: [uml-devel] ALSA and host audio relay in UML
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Luca Saiu <saiu@lipn.univ-paris13.fr>
Cc: marionnet-dev <marionnet-dev@marionnet.org>, Abdelouahed <abdel.ouahed@hotmail.fr>, user-mode-linux-devel@lists.sourceforge.net, Jonathan Roudiere <Jonathan.Roudiere@lipn.univ-paris13.fr>

On Mon, Jul 28, 2008 at 04:31:06PM +0200, Luca Saiu wrote:
> That feature works very well, but as far as I can understand from the 
> source and from my tests, it's limited to OSS. 

The host audio driver just uses the host's /dev/sound/dsp and
/dev/sound/mixer.  Are these OSS-specific?  If so, and you want to use
different host interfaces, it should be simple to add support for them
to the driver, which is about the simplest possible UML driver.  If
there are equivalent ALSA device files with different names, UML has
dsp= and mixer= flags to allow it to use different devices.

     	 	      	 Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
