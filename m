Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C58kU-0002Er-Vq for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Sep 2004 13:08:58 -0700
Received: from osiris.silug.org ([64.240.156.225])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1C58kU-00047C-6P
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Sep 2004 13:08:58 -0700
From: Steven Pritchard <steve@silug.org>
Subject: Re: [uml-devel] glibc and NPTL, problem, workarounds, etc.
Message-ID: <20040908200852.GA31375@osiris.silug.org>
References: <Pine.LNX.4.58.0409081440150.3136@sparrow>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409081440150.3136@sparrow>
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
Date: Wed, 8 Sep 2004 15:08:52 -0500
To: William Stearns <wstearns@pobox.com>
Cc: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Wed, Sep 08, 2004 at 03:02:03PM -0400, William Stearns wrote:
> 	The workaround to the above is this:
> 
> export LD_ASSUME_KERNEL=2.4.1
> exec /bin/bash

Couldn't you just boot with LD_ASSUME_KERNEL=2.4.1 on the kernel
command line?  ISTR that anything not processed by the kernel ends up
in init's environment.

Unfortunately, I don't have an easy way to test this at the moment...

Steve
-- 
Steven Pritchard - K&S Pritchard Enterprises, Inc.
Email: steve@kspei.com             http://www.kspei.com/
Phone: (618)398-7360               Mobile: (618)567-7320


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
