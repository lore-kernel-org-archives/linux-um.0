Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <richard@sigma-star.at>) id 1eGjwA-0006Ay-2g
 for user-mode-linux-devel@lists.sourceforge.net;
 Mon, 20 Nov 2017 11:08:26 +0000
Received: from mail.sigma-star.at ([95.130.255.111])
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.89)
 id 1eGjw8-0006O5-IQ for user-mode-linux-devel@lists.sourceforge.net;
 Mon, 20 Nov 2017 11:08:26 +0000
From: Richard Weinberger <richard@sigma-star.at>
Date: Mon, 20 Nov 2017 11:51:05 +0100
Message-ID: <40848754.jqcdyRAXiS@blindfold>
In-Reply-To: <20171120073925.32715-3-anton.ivanov@kot-begemot.co.uk>
References: <20171120073925.32715-1-anton.ivanov@kot-begemot.co.uk>
 <20171120073925.32715-3-anton.ivanov@kot-begemot.co.uk>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH v9 2/2] High Performance UML Vector Network
 Driver
List-Id: The user-mode Linux development list
 <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: anton.ivanov@kot-begemot.co.uk, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Anton,

Am Montag, 20. November 2017, 08:39:25 CET schrieb anton.ivanov@kot-
begemot.co.uk:
> +#define VECTOR_NUM_STATS	ARRAY_SIZE(ethtool_stats_keys)
> +
> +/* Used in the 4.4 OpenWRT backport */
> +
> +#if LINUX_VERSION_CODE <= KERNEL_VERSION(4, 7, 0)
> +static inline void netif_trans_update(struct net_device *dev)
> +{
> +	struct netdev_queue *txq = netdev_get_tx_queue(dev, 0);
> +
> +	if (txq->trans_start != jiffies)
> +		txq->trans_start = jiffies;
> +}
> +#endif

Didn't checkpatch.pl puke here?

Thanks,
//richard

-- 
sigma star gmbh - Eduard-Bodem-Gasse 6 - 6020 Innsbruck - Austria
ATU66964118 - FN 374287y

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

