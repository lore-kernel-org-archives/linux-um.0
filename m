Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B2eHK-00086k-AO for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 14 Mar 2004 14:40:18 -0800
Received: from mta9.adelphia.net ([68.168.78.199])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1B2eHH-0004rN-8s for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 14 Mar 2004 14:40:15 -0800
Received: from mizar.alcor.net ([68.64.159.24]) by mta9.adelphia.net
	(InterMail vM.5.01.06.08 201-253-122-130-108-20031117) with ESMTP
	id <20040314224009.TRXH1423.mta9.adelphia.net@mizar.alcor.net>
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 14 Mar 2004 17:40:09 -0500
Received: from mdz by mizar.alcor.net with local (Exim 4.30)
	id 1B2eHB-0001Hy-3b for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 14 Mar 2004 14:40:09 -0800
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] /dev/random oddity
Message-ID: <20040314224008.GY28592@alcor.net>
References: <20040313014957.GB13419@speedy.schwinge.homeip.net>
	<405309FE.6020603@darkman.de> <405324DB.3030404@lig.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <405324DB.3030404@lig.net>
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
Date: Sun, 14 Mar 2004 14:40:08 -0800
To: user-mode-linux-devel@lists.sourceforge.net

On Sat, Mar 13, 2004 at 10:12:27AM -0500, Stephen D. Williams wrote:

> This is a bit beyond our scope here, but one ideal source for randomness 
> is LavaRnd: http://www.lavarnd.org/

LavaRnd is software, and like any other software cannot be a source of
entropy.  From reading the web page, it seems to rely on hardware to import
entropy from an external source, which is less than ideal for use with UML.

If the host has a steady supply of randomness from any source, then UML
should be able to simply read from /dev/random on the host.

-- 
 - mdz


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
