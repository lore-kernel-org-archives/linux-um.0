Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DClY6-0006ei-7A for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Mar 2005 13:31:58 -0800
Received: from rimuhosting.com ([69.90.33.248])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DClY4-0007D5-3Y
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Mar 2005 13:31:57 -0800
Received: from [192.168.1.100] (222-152-20-160.jetstream.xtra.co.nz
	[222.152.20.160]) (authenticated bits=0)
	by rimuhosting.com (8.12.8/8.12.8) with ESMTP id j2JLVnpj001651
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 19 Mar 2005 21:31:52 GMT
Message-ID: <423C9A44.2020802@rimuhosting.com>
From: Peter <peter.spamcatcher@rimuhosting.com>
MIME-Version: 1.0
References: <cbec11ac05031719187cb8e7d2@mail.gmail.com>
	<200503181843.05832.rob@landley.net>
In-Reply-To: <200503181843.05832.rob@landley.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Running JDK1.5 Maxes Out CPU
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
Date: Sun, 20 Mar 2005 09:31:48 +1200
To: user-mode-linux-devel@lists.sourceforge.net

Hi.

JDK1.4 runs well on UML guests.

JDK1.5 does not appear to run well on the UML guests.  After the process 
runs for a bit it ends up sitting at 100% CPU.

I have had problems on 2.4 kernels up to 2.6.9 guest kernels.  I have 
reproduced the problem on different guest distros (Debian, FC, and 
WBEL3).  And the problem has been reported by other users on the mailing 
list here.

I do not see this problem on non-UML servers.

I am not sure what could be going on.  But it seems possible that the 
Java 1.5 VM is hitting some issue with the UML guest kernel.

To reproduce the problem (preferably on a Debian or FC/RHEL based 
distro) download this:
http://downloads.rimuhosting.com/installjava.sh

Comment out the 1.4.2 file/dir at the top.  Uncomment the 1.5 file/dir 
variables

Run that script (it will install the 1.5 JDK).

Download and run http://downloads.rimuhosting.com/installtomcat5.sh

It will install tomcat5.5.7 under /usr/local/tomcat.  Add a tomcat user. 
  And an /etc/init.d/tomcat stop/start/kill script.

Start tomcat with /etc/init.d/tomcat start

Run ab (ab is part of apache) like this:

ab -c 10 -n 10000 
http://localhost:8080/jsp-examples/jsp2/tagfiles/products.jsp

Eventually the Java process will max out the CPU.  Usually after 
200-2000 requests.

"jstack $parentjavapid" will show the Java code that is executing.  Not 
that helpful.

strace on the java pids don't seem to show/help much.

Your help reproducing and resolving this problem would be greatly 
appreciated.

Regards, Peter


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
