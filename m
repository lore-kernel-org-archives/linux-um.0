Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ArRPq-0004hP-PK
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 12 Feb 2004 16:42:46 -0800
Received: from almesberger.net ([63.105.73.238] helo=host.almesberger.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1ArRM0-00037U-Hv
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 12 Feb 2004 16:38:48 -0800
From: Werner Almesberger <werner@almesberger.net>
Message-ID: <20040212214058.R25203@almesberger.net>
References: <20040208185334.H9021@almesberger.net> <20040212154958.GB2834@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040212154958.GB2834@ccure.user-mode-linux.org>; from jdike@addtoit.com on Thu, Feb 12, 2004 at 10:49:58AM -0500
Subject: [uml-devel] Re: patch/RFC: add bypass for "debug" parameter
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 12 Feb 2004 21:40:58 -0300
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Jeff Dike wrote:
> Would there be any loud screams of horror if I were to change the UML
> 'debug' switch to 'gdb' or something?

Only screams of joy from my side :-)

Perhaps a parameter to pass further parameters verbatim to the
kernel, i.e. something like the "--" some programs use, could
be useful too, just in case someone invents a configurable
"global debug buffer" or such.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
