Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AzG2i-0008GO-Ho for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Mar 2004 06:11:12 -0800
Received: from grassmarket.ucs.ed.ac.uk ([129.215.166.64])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AzFU3-0001Zh-8F for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Mar 2004 05:35:23 -0800
Message-ID: <4048871F.4080400@sms.ed.ac.uk>
From: Jonathan Boler <j.m.boler@sms.ed.ac.uk>
MIME-Version: 1.0
References: <20040305100144.E26293@almesberger.net>
In-Reply-To: <20040305100144.E26293@almesberger.net>
Content-Type: multipart/mixed; boundary="------------080902000808090309060806"
Subject: [uml-devel] Re: [uml-user] hack: avoid "Registered protocol family 2"
	hang
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
Date: Fri, 05 Mar 2004 13:56:47 +0000
To: Werner Almesberger <werner@almesberger.net>
Cc: user-mode-linux-devel@lists.sourceforge.net


This is a multi-part message in MIME format.
--------------080902000808090309060806
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Werner Almesberger wrote:
> I've attached a little hack that should make the hang after
> NET: Registered protocol family 2
> disappear. This isn't the real solution (haven't yet figured
> out how this is truly supposed to work on non-SMP), but it 
> gives me a happier UML :-)
> 
> - Werner
> 

The actual bug has been fixed. The problem was the host cpu Hz was being 
truncated to a signed int so uml wouldn't run on a host faster than 2.1Ghz.

Patch attached

Jonathan

--------------080902000808090309060806
Content-Type: text/plain;
 name="hz.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hz.patch"

--- arch/um/kernel/time.c       2004-03-05 13:54:12.262248632 +0000
+++ ../../linux-2.6.3/arch/um/kernel/time.c     2004-03-04 08:54:33.000000000 +0000
@@ -88,7 +88,8 @@
 static unsigned long long get_host_hz(void)
 {
        char mhzline[16], *end;
-       int ret, mult, mhz, rest, len;
+       int ret, mult, rest, len;
+       unsigned long long mhz;
 
        ret = cpu_feature("cpu MHz", mhzline, 
                          sizeof(mhzline) / sizeof(mhzline[0]));


--------------080902000808090309060806--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
