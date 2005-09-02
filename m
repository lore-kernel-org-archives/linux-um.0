Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EB90M-0008JS-R8	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Sep 2005 03:42:42 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EB90K-0001bf-DN
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Sep 2005 03:42:43 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 10/12] UML - Allow host capability usage to be
	disabled
References: <200509012217.j81MHKE7011567@ccure.user-mode-linux.org>
In-Reply-To: <200509012217.j81MHKE7011567@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509021239.23859.blaisorblade@yahoo.it>
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
Date: Fri, 2 Sep 2005 12:39:23 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, akpm@osdl.org, linux-kernel@vger.kernel.org, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

On Friday 02 September 2005 00:17, Jeff Dike wrote:
> From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
>
> Add new cmdline setups:
>   - noprocmm
>   - noptracefaultinfo
> In case of testing, they can be used to switch off usage of
> /proc/mm and PTRACE_FAULTINFO independently.
Is "skas0" cmd line option preserved?
> Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
> Signed-off-by: Jeff Dike <jdike@addtoit.com>
>
> Index: test/arch/um/os-Linux/start_up.c
> ===================================================================
> --- test.orig/arch/um/os-Linux/start_up.c	2005-09-01 16:42:42.000000000
> -0400 +++ test/arch/um/os-Linux/start_up.c	2005-09-01 16:51:23.000000000
> -0400 @@ -275,6 +275,30 @@
>  	check_ptrace();
>  }
>
> +static int __init noprocmm_cmd_param(char *str, int* add)
> +{
> +	proc_mm = 0;
> +	return 0;
> +}
> +
> +__uml_setup("noprocmm", noprocmm_cmd_param,
> +"noprocmm\n"
> +"    Turns off usage of /proc/mm, even if host supports it.\n"
> +"    To support /proc/mm, the host needs to be patched using\n"
> +"    the current skas3 patch.\n\n");
> +
> +static int __init noptracefaultinfo_cmd_param(char *str, int* add)
> +{
> +	ptrace_faultinfo = 0;
> +	return 0;
> +}
> +
> +__uml_setup("noptracefaultinfo", noptracefaultinfo_cmd_param,
> +"noptracefaultinfo\n"
> +"    Turns off usage of PTRACE_FAULTINFO, even if host supports\n"
> +"    it. To support PTRACE_FAULTINFO, the host needs to be patched\n"
> +"    using the current skas3 patch.\n\n");
> +
>  #ifdef UML_CONFIG_MODE_SKAS
>  static inline void check_skas3_ptrace_support(void)
>  {
>
>
>
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
> Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
> Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
