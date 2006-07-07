Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FysJR-0004EC-VX for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Jul 2006 08:32:14 -0700
Received: from smtp3.oregonstate.edu ([128.193.0.12])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FysJQ-0001LH-B2
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Jul 2006 08:32:13 -0700
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Fri, 7 Jul 2006 08:31:50 -0700
Message-ID: <7B4268E5ACB878429B58D4BE5B780E83010B6B42@NWS-EXCH2.nws.oregonstate.edu>
In-reply-to: <200607070033.k670Xt1w008752@ccure.user-mode-linux.org>
From: "Brock, Anthony - NET" <Anthony.Brock@oregonstate.edu>
Subject: Re: [uml-devel] [PATCH 19/19] UML - Make mconsole version
	requestshappen in a process
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
To: Jeff Dike <jdike@addtoit.com>, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

So what impact does this have on the following quote from
http://user-mode-linux.sourceforge.net/mconsole.html :


It's a simple no-op which can be used to check that a UML is running.
It's also a way of sending an interrupt to the UML. This is sometimes
useful on SMP hosts, where there's a bug which causes signals to UML to
be lost, often causing it to appear to hang. Sending such a UML the
mconsole version command is a good way to 'wake it up' before networking
has been enabled, as it does not do anything to the function of the UML.


I'm running UML on an SMP machine, but have never encountered the "hang"
issue. Is this text still accurate? Also, can this command still be used
to "wake up" a UML process? Is this still the recommended means for
verifying that a UML process if running?

Tony

> -----Original Message-----
> From: user-mode-linux-devel-bounces@lists.sourceforge.net 
> [mailto:user-mode-linux-devel-bounces@lists.sourceforge.net] 
> On Behalf Of Jeff Dike
> Sent: Thursday, July 06, 2006 5:34 PM
> To: akpm@osdl.org
> Cc: linux-kernel@vger.kernel.org; 
> user-mode-linux-devel@lists.sourceforge.net
> Subject: [uml-devel] [PATCH 19/19] UML - Make mconsole 
> version requestshappen in a process
> 
> Handling a host mconsole version request must be done in a 
> process context
> rather than interrupt context now that utsname information can be 
> process-specific rather than global.
> 
> Signed-off-by: Jeff Dike <jdike@addtoit.com>
> 
> Index: linux-2.6.16/arch/um/drivers/mconsole_user.c
> ===================================================================
> --- linux-2.6.16.orig/arch/um/drivers/mconsole_user.c
> +++ linux-2.6.16/arch/um/drivers/mconsole_user.c
> @@ -18,7 +18,12 @@
>  #include "umid.h"
>  
>  static struct mconsole_command commands[] = {
> -	{ "version", mconsole_version, MCONSOLE_INTR },
> +	/* With uts namespaces, uts information becomes 
> process-specific, so
> +	 * we need a process context.  If we try handling this 
> in interrupt
> +	 * context, we may hit an exiting process without a valid uts
> +	 * namespace.
> +	 */
> +	{ "version", mconsole_version, MCONSOLE_PROC },
>  	{ "halt", mconsole_halt, MCONSOLE_PROC },
>  	{ "reboot", mconsole_reboot, MCONSOLE_PROC },
>  	{ "config", mconsole_config, MCONSOLE_PROC },
> 
> 
> Using Tomcat but need to do more? Need to support web 
> services, security?
> Get stuff done quickly with pre-integrated technology to make 
> your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on 
> Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&
> dat=121642
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
> 

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
