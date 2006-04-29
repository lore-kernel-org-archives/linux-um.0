Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FZqdd-0001yS-1z for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 29 Apr 2006 07:41:37 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FZqdb-00043F-68
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 29 Apr 2006 07:41:37 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [PATCH 0/6] UML - Small patches for 2.6.17
References: <200604281601.k3SG11MJ007510@ccure.user-mode-linux.org>
	<20060428165534.6067f5aa.akpm@osdl.org>
In-Reply-To: <20060428165534.6067f5aa.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604291641.19864.blaisorblade@yahoo.it>
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
Date: Sat, 29 Apr 2006 16:41:18 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org

On Saturday 29 April 2006 01:55, Andrew Morton wrote:
> Jeff Dike <jdike@addtoit.com> wrote:
> > These patches are 2.6.17 material.
>
> "remove NULL checks and add some CodingStyle" isn't.

Being restrictive is ok, but keeping patches in queues for longer than needed 
creates more headaches than it solves, in my experience.

> Unless one considers 
> UML coding style to be a bug, which is an attractive idea ;)

Well, we're slowly working on that... very slowly... I've thought multiple 
times to at least run Lindent on arch/um but I've not spoken up because of 
all the conflicts we (me and Jeff) would get with patches in our queues.

However, there are occasions in which we get conflicts anyway for other 
reorganization, and in that case Lindent would be useful. Ok Jeff? I'm 
speaking for instance about moving to os-Linux and such.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
