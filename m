Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AhZyO-0007Rj-Nb for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Jan 2004 11:49:40 -0800
Received: from mta9.adelphia.net ([68.168.78.199])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AhZyO-0000BG-DS for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Jan 2004 11:49:40 -0800
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] Re: Panic with slirp transport and gcc 3.3
Message-ID: <20040116194929.GH1478@alcor.net>
References: <20031230184330.GD1365@alcor.net>
	<200401060258.i062wWFI023087@ccure.user-mode-linux.org>
	<20040108070718.GI28393@alcor.net>
	<20040112183623.GB1436@alcor.net> <20040113152542.GD7072@seventeen>
	<200401131730.i0DHUMhg002358@ccure.user-mode-linux.org>
	<20040113185156.GW1514@alcor.net>
	<200401160238.i0G2cYrf004298@ccure.user-mode-linux.org>
	<20040116023826.GV1478@alcor.net>
	<200401162004.i0GK4LVW003439@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401162004.i0GK4LVW003439@ccure.user-mode-linux.org>
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
Date: Fri, 16 Jan 2004 11:49:29 -0800
To: Jeff Dike <jdike@addtoit.com>
Cc: Bill Allombert <allomber@math.u-bordeaux.fr>, user-mode-linux-devel@lists.sourceforge.net, 176485@bugs.debian.org

On Fri, Jan 16, 2004 at 03:04:21PM -0500, Jeff Dike wrote:

> % file linux-176485 
> linux-176485: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), statically linked, stripped
> 
> Having it stripped is inconvenient.  Can you compress a debuggable binary
> and put it someplace I can grab it?

http://people.debian.org/~mdz/temp/linux-176485.gz

(ETA ~10 minutes; it's rather enormous)

-- 
 - mdz


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
