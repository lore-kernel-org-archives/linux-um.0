Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AQ1Ki-0007zD-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 29 Nov 2003 01:24:08 -0800
Received: from smtp3.att.ne.jp ([165.76.15.139])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AQ1Ki-0003Hb-Fm
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 29 Nov 2003 01:24:08 -0800
From: Richard Potter <sbuml@zar.att.ne.jp>
Subject: Re: [uml-devel] How to copy COW files to another machine across the network?
In-Reply-To: <Pine.GSO.4.21.0311281013200.21469-100000@waterleaf.sonytel.be>
References: <50376.130.217.250.13.1069985464.squirrel@webmail.scms.waikato.ac.nz> <Pine.GSO.4.21.0311281013200.21469-100000@waterleaf.sonytel.be>
Message-Id: <20031129182306.3FFA.SBUML@zar.att.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 29 Nov 2003 18:24:07 +0900
To: user-mode-linux-devel@lists.sourceforge.net

> On Fri, 28 Nov 2003, Shao-Lin Joseph Chung wrote:
> > As the subject says, I'm trying to copy the COW files across the network. 
> > But the size of those copies got expanded to the same size of the backing
> > file.
> > 
> > Is there a way to keep these COWs small & cute?  ;-)
> 
> From rsync(1):
> 
>     -S, --sparse                handle sparse files efficiently
> 

The -S flag when creating a tar file also works nicely.  Then when
expanding, tar will create a sparse file very quickly, just processing the
used bytes.

--Richard

> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
