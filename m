Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BTZMB-0004kj-3Y for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 May 2004 21:52:35 -0700
Received: from ns.theshore.net ([216.156.129.65] helo=www.theshore.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BTZMA-0005h6-Mw for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 May 2004 21:52:34 -0700
Message-ID: <001001c4446f$c323d2e0$0201a8c0@hawk>
From: "Christopher S. Aker" <caker@theshore.net>
References: <20040229043549.GA8583@ccure.user-mode-linux.org>
	<02dc01c43c4a$bb7c0490$2000000a@schlepptopp>
	<1084831251.1230.4.camel@chartreuse>
	<03ff01c43c5d$7db6e5e0$2000000a@schlepptopp>
	<20040518175904.GB29114@ccure.user-mode-linux.org>
	<1084987654.2250.4.camel@chartreuse>
	<006f01c443b2$29434290$0201a8c0@hawk>
	<1085646154.1264.6.camel@chartreuse>
	<003b01c443cc$8349fcb0$0201a8c0@hawk>
	<1085658646.1256.9.camel@chartreuse>
Subject: Re: [uml-devel] [PATCH] host context switch reduction Benchmarks
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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
Date: Thu, 27 May 2004 23:53:42 -0500
To: Laurent Vivier <LaurentVivier@wanadoo.fr>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Using Mysql's "run-all-tests" as a benchmark, the sysemu patches provide about a
33% performance improvement over a "vanilla" UML+skas.

w/ sysemu:
real    13m57.353s
user    2m17.370s
sys     3m54.310s

w/o sysemu:
real    18m38.329s
user    2m37.370s
sys     6m3.040s

Mysql test results here:
http://www.theshore.net/~caker/uml/sysemu-benchmarks.txt


For a kernel compile, the improvement isn't as drastic -- but compiling spends
most of it's time in user-space...

w/ sysemu:
real    5m15.182s
user    4m22.470s
sys     0m52.230s

w/o sysemu:
real    5m28.466s
user    4m32.030s
sys     0m55.370s

Nice stuff, thanks!
-Chris



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
