Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DHRG7-0000xD-UU for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Apr 2005 10:52:43 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DHRFm-0002p8-SD for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Apr 2005 10:52:43 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] question about UML sigcontext in tt mode
References: <003501c535d8$e8574a50$90b3c68a@st.com>
In-Reply-To: <003501c535d8$e8574a50$90b3c68a@st.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504012051.31964.blaisorblade@yahoo.it>
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
Date: Fri, 1 Apr 2005 20:51:31 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Alex LIU <alex.liu@st.com>

On Thursday 31 March 2005 12:03, Alex LIU wrote:
> Hi,all:
>
> I have a question about the sigcontext in tt mode.The union uml_pt_regs is
> defined as below(in uml-2.6.7):
>
> --------------------------------
> union uml_pt_regs {
> #ifdef UML_CONFIG_MODE_TT
>  struct tt_regs {
>   long syscall;
>   void *sc;
>  } tt;
> #endif
> #ifdef UML_CONFIG_MODE_SKAS
>  struct skas_regs {
>   unsigned long regs[HOST_FRAME_SIZE];
>   unsigned long fp[HOST_FP_SIZE];
>   unsigned long xfp[HOST_XFP_SIZE];
>   unsigned long fault_addr;
>   unsigned long fault_type;
>   unsigned long trap_type;
>   long syscall;
>   int is_user;
>  } skas;
> #endif
> };
> -------------------------------------
>
> Then why the tt.sc is defined as void while not as struct sigcontext?
> Thanks!

I think because of header inclusion problems... you can't include userspace 
header in kernelspace files and so on. And the above can be included by both 
kind of files, being in arch/um/include.

This could be solved however with a:
struct sigcontext;
...
struct sigcontext * sc;

instead of

void* sc;

I've not checked however if sc is actually a sigcontext - I rely on what you 
say.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
