Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G0m0H-0008RY-Et for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jul 2006 14:12:28 -0700
Received: from terminus.zytor.com ([192.83.249.54] ident=root)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1G0m0G-00086w-64
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jul 2006 14:12:17 -0700
Message-ID: <44B5659E.5070000@zytor.com>
Date: Wed, 12 Jul 2006 14:11:58 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
References: <200607121640.k6CGe6nP021236@ccure.user-mode-linux.org>
	<200607122056.01202.blaisorblade@yahoo.it>
In-Reply-To: <200607122056.01202.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 4/5] UML - Reenable SysRq support
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: akpm@osdl.org, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Blaisorblade wrote:
> On Wednesday 12 July 2006 18:40, Jeff Dike wrote:
>> Sysrq works fine on UML.
>>
>> Signed-off-by: Jeff Dike <jdike@addtoit.com>
>>
>> Index: linux-2.6.17/lib/Kconfig.debug
>> ===================================================================
>> --- linux-2.6.17.orig/lib/Kconfig.debug	2006-07-12 11:26:41.000000000 -0400
>> +++ linux-2.6.17/lib/Kconfig.debug	2006-07-12 11:33:02.000000000 -0400
>> @@ -18,7 +18,6 @@ config ENABLE_MUST_CHECK
>>
>>  config MAGIC_SYSRQ
>>  	bool "Magic SysRq key"
>> -	depends on !UML
>>  	help
>>  	  If you say Y here, you will have some control over the system even
>>  	  if the system crashes for example during kernel debugging (e.g., you
> Please reject this patch, the setting for UML is just elsewhere, in 
> arch/um/Kconfig (and depends on MCONSOLE).
> 
> If kbuild doesn't handle well having an option declared twice now (it isn't 
> very happy but it worked when I added the above dependency) we can rename the 
> one in arch/um/Kconfig to MAGIC_SYSRQ_UML and make the one above like this 
> (untested):
> 
> config MAGIC_SYSRQ
> 	bool
> 	prompt "Magic SysRq key" if !UML
> 	depends on MAGIC_SYSRQ_UML || !UML
> 	default y if UML
> 

Why not:

config MAGIC_SYSRQ
	bool
	prompt "Magic SysRq key"
	depends on !UML || MCONSOLE
	default y if UML

	-hpa


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
