Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AwIqi-0001cT-4Y for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Feb 2004 02:34:36 -0800
Received: from smtp017.mail.yahoo.com ([216.136.174.114])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AwIhO-0003FC-7H for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Feb 2004 02:24:58 -0800
Message-ID: <403DC97E.4000407@yahoo.com.cn>
From: MeiJia <cfs_eric@yahoo.com.cn>
MIME-Version: 1.0
Subject: Re: [uml-devel] Fwd: Re: [uml-user] 2.6.3 hang on boot
References: <200402252038.42084.blaisorblade_spam@yahoo.it>
	<Pine.GSO.4.58.0402260830580.15349@altair.dur.ac.uk>
In-Reply-To: <Pine.GSO.4.58.0402260830580.15349@altair.dur.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Thu, 26 Feb 2004 18:25:02 +0800
To: M A Young <m.a.young@durham.ac.uk>
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

M A Young wrote:
> On Wed, 25 Feb 2004, BlaisorBlade wrote:
> 
> 
>>Hi, could you please take a look at this message? It seems like libc, in RH9,
>>still trigger "vsyscall" problems. I'm not sure, however, since the vsyscall
>>reference in the stack frame could be botched. However there is init getting
>>SIGSEGV.
> 
> 
> I certainly knew that a RH9 glibc in the client can trigger the vsyscall
> segfault hang, but it only happens if the /lib/tls libraries are present;
> presumably the same code is present but it moved from the tls only code to
> the general code for the FC1 glibc. This is why I originally thought it
> was an issue with tls and suggested hiding the /lib/tls libraries. I think
> the fix works in both cases.
> 
> 	Michael Young

really appreciate your help BlaisorBlade & Michael! UML is so wonderful!

MeiJia



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
