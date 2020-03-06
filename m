Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail26.static.mailgun.info ([104.130.122.26])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jA6Yi-0003JI-Jt
 for linux-um@lists.infradead.org; Fri, 06 Mar 2020 06:34:10 +0000
From: Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [PATCH net-next 7/7] wil6210: reject unsupported coalescing params
References: <20200306010602.1620354-1-kuba@kernel.org>
 <20200306010602.1620354-8-kuba@kernel.org>
Date: Fri, 06 Mar 2020 08:33:55 +0200
In-Reply-To: <20200306010602.1620354-8-kuba@kernel.org> (Jakub Kicinski's
 message of "Thu, 5 Mar 2020 17:06:02 -0800")
Message-ID: <8736amouuk.fsf@kamboji.qca.qualcomm.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Jakub Kicinski <kuba@kernel.org>
Cc: mkubecek@suse.cz, merez@codeaurora.org, pv-drivers@vmware.com, GR-Linux-NIC-Dev@marvell.com, doshir@vmware.com, leon@kernel.org, manishc@marvell.com, linux-rdma@vger.kernel.org, richard@nod.at, jdike@addtoit.com, linux-um@lists.infradead.org, edumazet@google.com, jasowang@redhat.com, jgg@ziepe.ca, dledford@redhat.com, netdev@vger.kernel.org, gregkh@linuxfoundation.org, linux-wireless@vger.kernel.org, hayeswang@realtek.com, davem@davemloft.net, anton.ivanov@cambridgegreys.com

Jakub Kicinski <kuba@kernel.org> writes:

> Set ethtool_ops->supported_coalesce_params to let
> the core reject unsupported coalescing parameters.
>
> This driver did not previously reject unsupported parameters.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

As this goes to net-next:

Acked-by: Kalle Valo <kvalo@codeaurora.org>

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

