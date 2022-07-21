Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-bn8nam11on2040.outbound.protection.outlook.com ([40.107.236.40] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEZZX-00APTm-6p
	for linux-um@lists.infradead.org; Thu, 21 Jul 2022 17:02:48 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH] ubd:do not initialise statics to 0.
Date: Thu, 21 Jul 2022 17:02:40 +0000
Message-ID: <7cafc7ad-be8f-4093-1df8-8bbae37308ad@nvidia.com>
References: <20220720192916.7564-1-gaoxin@cdjrlc.com>
In-Reply-To: <20220720192916.7564-1-gaoxin@cdjrlc.com>
Content-Language: en-US
Content-ID: <9ACBAE718C403043A89C48E62B6C9E69@namprd12.prod.outlook.com>
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
To: Xin Gao <gaoxin@cdjrlc.com>, "richard@nod.at" <richard@nod.at>, "anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>, "johannes@sipsolutions.net" <johannes@sipsolutions.net>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, "martin.petersen@oracle.com" <martin.petersen@oracle.com>, "hoeppner@linux.ibm.com" <hoeppner@linux.ibm.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, "frederic.danis@collabora.com" <frederic.danis@collabora.com>, "mcgrof@kernel.org" <mcgrof@kernel.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 7/20/2022 12:29 PM, Xin Gao wrote:
> do not initialise statics to 0.
> 
> Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
> ---

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

-ck


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

