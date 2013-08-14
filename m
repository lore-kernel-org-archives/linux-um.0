Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rjones@redhat.com>) id 1V9fLv-00014O-M4
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Aug 2013 17:59:23 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V9fLt-0000cs-ES for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Aug 2013 17:59:22 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r7EHxFZ8007983
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 14 Aug 2013 13:59:15 -0400
Received: from localhost (vpn1-4-41.ams2.redhat.com [10.36.4.41])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id r7EHxE7j028614 for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 14 Aug 2013 13:59:14 -0400
Date: Wed, 14 Aug 2013 18:59:11 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20130814175911.GG10864@redhat.com>
References: <20130809204355.GA10864@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130809204355.GA10864@redhat.com>
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] Performance tests (was: Using UML in libguestfs)
To: user-mode-linux-devel@lists.sourceforge.net


I performed some benchmarks against KVM:

http://rwmj.wordpress.com/2013/08/14/performance-of-user-mode-linux-as-a-libguestfs-backend/#content

Notes for those that don't want to read all that, there are at least
two bugs I found:

(1) fsync /dev/ubda (in the guest) is not honoured by the user-mode
linux process.  It should do an fsync on the corresponding backing file.

(2) The ssl<N>=... serial port is really slow, at least 10 times
slower than virtio-serial which is the equivalent KVM feature.
libguestfs is chatty over the serial port, and so this has a
significant knock-on impact all over the place.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW

------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

