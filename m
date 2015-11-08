Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <aivanov@Brocade.com>) id 1ZvSOs-0002Co-Bx
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 Nov 2015 16:01:02 +0000
Received: from mx0a-000f0801.pphosted.com ([67.231.144.122])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZvSOq-0004MA-3y
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 Nov 2015 16:01:02 +0000
Received: from pps.filterd (m0048193.ppops.net [127.0.0.1])
	by mx0a-000f0801.pphosted.com (8.15.0.59/8.15.0.59) with SMTP id
	tA8Ex14K012611 for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 8 Nov 2015 07:18:22 -0800
Received: from brmwp-exmb11.corp.brocade.com ([208.47.132.227])
	by mx0a-000f0801.pphosted.com with ESMTP id 1y1bt1akat-1
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 08 Nov 2015 07:18:22 -0800
From: Anton Ivanov <aivanov@Brocade.com>
Date: Sun, 8 Nov 2015 15:18:04 +0000
Message-ID: <563F66E2.6060509@brocade.com>
References: <1446994702-21240-1-git-send-email-aivanov@brocade.com>
In-Reply-To: <1446994702-21240-1-git-send-email-aivanov@brocade.com>
Content-Language: en-US
Content-ID: <CEB19F4407D79148A10064DE2ACAE805@brocade.local>
MIME-Version: 1.0
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
Subject: Re: [uml-devel] [PATCH] Missing includes in start up
To: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

Hi Richard,

This is vs your tree, 4.x master branch in linus repo actually has 
sys/resource.h

Pls ignore the patch.

A.

On 08/11/15 14:58, Anton Ivanov wrote:
> Modifying RLIMIT requires including sys/time.h and sys/resource.h
>
> Signed-off-by: Anton Ivanov <aivanov@brocade.com>
> ---
>   arch/um/os-Linux/start_up.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
> index 425162e..c1811df 100644
> --- a/arch/um/os-Linux/start_up.c
> +++ b/arch/um/os-Linux/start_up.c
> @@ -16,6 +16,8 @@
>   #include <sys/stat.h>
>   #include <sys/wait.h>
>   #include <asm/unistd.h>
> +#include <sys/time.h>
> +#include <sys/resource.h>
>   #include "init.h"
>   #include "os.h"
>   #include "mem_user.h"

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

