Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20741C3DA70
	for <linux-um@archiver.kernel.org>; Tue, 30 Jul 2024 15:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Otzo7JtBmvInTgWwZ5gyza5Sq3yQJQ0t6s066+sbNL0=; b=OSoXMs/YjhgUJr9Y3viLYy3fTg
	YGE4RO61hPBAK9MZm9gaAlpYJg+AKbAde0W5HJ5W0FHGh1QcEweAcoYptAcMYVSZm+Y/AchAVIjlt
	qhdsssRMZs3BPQCGDnwKMK8xWSCn2NljmUmvnEcSubq2s/7l+i3nORsOCrrrGkGCPzhgbd4IwScR0
	dkbwqgcOHjzX6+PCJYnGbCgTrJYx+LGbCB2DrJET44PjgjVtXll4SLUalN4s4UOpBpNvE4Te9RDXE
	HvEE3IoQB22dq9UNH/4MDgYCSO/hCoahPT2LIMm/JG0jbo7HYsayJaT8W4bBTvBY3oTc3kWxxeIVz
	IrjCylqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYop9-0000000FflC-2u8e;
	Tue, 30 Jul 2024 15:31:39 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYop6-0000000Ffjz-44aD
	for linux-um@lists.infradead.org;
	Tue, 30 Jul 2024 15:31:38 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1sYo9o-007mdK-Qm; Tue, 30 Jul 2024 14:48:57 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.96)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1sYo9k-00BmiZ-0f;
	Tue, 30 Jul 2024 15:48:56 +0100
Message-ID: <99fa59c8-28b5-4541-b606-bb99425ed96c@kot-begemot.co.uk>
Date: Tue, 30 Jul 2024 15:48:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vector_user: add VDE support
To: Renzo Davoli <renzo@cs.unibo.it>, linux-um@lists.infradead.org
Cc: luca.bassi14@studio.unibo.it, davide.berardi@unimercatorum.it
References: <ZqjwriuvnqgDmwJM@cs.unibo.it>
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
In-Reply-To: <ZqjwriuvnqgDmwJM@cs.unibo.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240730_083137_047202_1402269C 
X-CRM114-Status: GOOD (  17.54  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org



On 30/07/2024 14:54, Renzo Davoli wrote:
> This is the actual implementation of VDE support as a vector transport.
> 
> Signed-off-by: Renzo Davoli <renzo@cs.unibo.it>
> ---
>   arch/um/drivers/vector_user.c | 83 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 83 insertions(+)
> 
> diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
> index b16a5e5619d3..2ea67e6fd067 100644
> --- a/arch/um/drivers/vector_user.c
> +++ b/arch/um/drivers/vector_user.c
> @@ -46,6 +46,9 @@
>   #define TRANS_FD "fd"
>   #define TRANS_FD_LEN strlen(TRANS_FD)
>   
> +#define TRANS_VDE "vde"
> +#define TRANS_VDE_LEN strlen(TRANS_VDE)
> +
>   #define VNET_HDR_FAIL "could not enable vnet headers on fd %d"
>   #define TUN_GET_F_FAIL "tapraw: TUNGETFEATURES failed: %s"
>   #define L2TPV3_BIND_FAIL "l2tpv3_open : could not bind socket err=%i"
> @@ -434,6 +437,84 @@ static struct vector_fds *user_init_fd_fds(struct arglist *ifspec)
>   	return NULL;
>   }
>   
> +/* enough char to store an int type */
> +#define ENOUGH(type) ((CHAR_BIT * sizeof(type) - 1) / 3 + 2)
> +#define ENOUGH_OCTAL(type) ((CHAR_BIT * sizeof(type) + 2) / 3)
> +/* vde_plug --descr xx --port2 xx --mod2 xx --group2 xx seqpacket://NN vnl (NULL) */
> +#define VDE_MAX_ARGC 12
> +#define VDE_SEQPACKET_HEAD "seqpacket://"
> +#define VDE_SEQPACKET_HEAD_LEN (sizeof(VDE_SEQPACKET_HEAD) - 1)
> +#define VDE_DEFAULT_DESCRIPTION "UML"
> +
> +static struct vector_fds *user_init_vde_fds(struct arglist *ifspec)
> +{
> +	char seqpacketvnl[VDE_SEQPACKET_HEAD_LEN + ENOUGH(int) + 1];
> +	char *argv[VDE_MAX_ARGC] = {"vde_plug"};
> +	int argc = 1;
> +	int rv;
> +	int sv[2];
> +	struct vector_fds *result = NULL;
> +
> +	char *vnl = uml_vector_fetch_arg(ifspec,"vnl");
> +	char *descr = uml_vector_fetch_arg(ifspec,"descr");
> +	char *port = uml_vector_fetch_arg(ifspec,"port");
> +	char *mode = uml_vector_fetch_arg(ifspec,"mode");
> +	char *group = uml_vector_fetch_arg(ifspec,"group");
> +	if (descr == NULL) descr = VDE_DEFAULT_DESCRIPTION;
> +
> +	argv[argc++] = "--descr";
> +	argv[argc++] = descr;
> +	if (port != NULL) {
> +		argv[argc++] = "--port2";
> +		argv[argc++] = port;
> +	}
> +	if (mode != NULL) {
> +		argv[argc++] = "--mod2";
> +		argv[argc++] = mode;
> +	}
> +	if (group != NULL) {
> +		argv[argc++] = "--group2";
> +		argv[argc++] = group;
> +	}
> +	argv[argc++] = seqpacketvnl;
> +	argv[argc++] = vnl;
> +	argv[argc++] = NULL;
> +
> +	rv = socketpair(AF_UNIX, SOCK_SEQPACKET, 0, sv);
> +	if (rv  < 0) {
> +		printk(UM_KERN_ERR "vde: seqpacket socketpair err %d", -errno);
> +		return NULL;
> +	}
> +	rv = os_set_exec_close(sv[0]);
> +	if (rv  < 0) {
> +		printk(UM_KERN_ERR "vde: seqpacket socketpair cloexec err %d", -errno);
> +		goto vde_cleanup_sv;
> +	}
> +	snprintf(seqpacketvnl, sizeof(seqpacketvnl), VDE_SEQPACKET_HEAD "%d", sv[1]);
> +
> +	run_helper(NULL, NULL, argv);
> +
> +	close(sv[1]);
> +
> +	result = uml_kmalloc(sizeof(struct vector_fds), UM_GFP_KERNEL);
> +	if (result == NULL) {
> +		printk(UM_KERN_ERR "fd open: allocation failed");
> +		goto vde_cleanup;
> +	}
> +
> +	result->rx_fd = sv[0];
> +	result->tx_fd = sv[0];
> +	result->remote_addr_size = 0;
> +	result->remote_addr = NULL;
> +	return result;
> +
> +vde_cleanup_sv:
> +	close(sv[1]);
> +vde_cleanup:
> +	close(sv[0]);
> +	return NULL;
> +}
> +
>   static struct vector_fds *user_init_raw_fds(struct arglist *ifspec)
>   {
>   	int rxfd = -1, txfd = -1;
> @@ -673,6 +754,8 @@ struct vector_fds *uml_vector_user_open(
>   		return user_init_unix_fds(parsed, ID_BESS);
>   	if (strncmp(transport, TRANS_FD, TRANS_FD_LEN) == 0)
>   		return user_init_fd_fds(parsed);
> +	if (strncmp(transport, TRANS_VDE, TRANS_VDE_LEN) == 0)
> +		return user_init_vde_fds(parsed);
>   	return NULL;
>   }
>   
> 
> 
> 
> 
Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

