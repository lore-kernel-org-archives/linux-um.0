Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation/features: Update the arch support status
 files
In-Reply-To: <20220609025656.143460-1-zhengzengkai@huawei.com>
References: <20220609025656.143460-1-zhengzengkai@huawei.com>
Date: Thu, 09 Jun 2022 09:37:07 -0600
Message-ID: <87pmjh4zmk.fsf@meer.lwn.net>
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
To: Zheng Zengkai <zhengzengkai@huawei.com>
Cc: chenhuacai@kernel.org, kernel@xen0n.name, deller@gmx.de, linux-parisc@vger.kernel.org, vincent.whitchurch@axis.com, richard@nod.at, linux-um@lists.infradead.org, palmer@dabbelt.com, linux-riscv@lists.infradead.org, vgupta@kernel.org, sergey.matyukevich@synopsys.com, linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, liwei391@huawei.com, zhengzengkai@huawei.com

Zheng Zengkai <zhengzengkai@huawei.com> writes:

> The arch support status files don't match reality as of v5.19-rc1,
> use the features-refresh.sh to refresh all the arch-support.txt files
> in place.
>
> Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>

I've applied this, but added a note to the changelog saying that the
main change is to add the loong architecture.

Thanks,

jon

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

