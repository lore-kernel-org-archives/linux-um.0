Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Tue, 15 Feb 2022 13:32:21 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH][next] treewide: Replace zero-length arrays with
 flexible-array members
Message-ID: <20220215193221.GA884407@embeddedor>
References: <20220215174743.GA878920@embeddedor>
 <202202151016.C0471D6E@keescook>
 <20220215192110.GA883653@embeddedor> <Ygv8wY75hNqS7zO6@unreal>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Ygv8wY75hNqS7zO6@unreal>
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
To: Leon Romanovsky <leon@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, GR-QLogic-Storage-Upstream@marvell.com, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-crypto@vger.kernel.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, mpi3mr-linuxdrv.pdl@broadcom.com, linux-staging@lists.linux.dev, linux-rpi-kernel@lists.infradead.org, sparmaintainer@unisys.com, linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, linux-ext4@vger.kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, greybus-dev@lists.linaro.org, linux-i3c@lists.infradead.org, linux-rdma@vger.kernel.org, linux-bluetooth@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-hardening@vger.kernel.org

On Tue, Feb 15, 2022 at 09:19:29PM +0200, Leon Romanovsky wrote:
> On Tue, Feb 15, 2022 at 01:21:10PM -0600, Gustavo A. R. Silva wrote:
> > On Tue, Feb 15, 2022 at 10:17:40AM -0800, Kees Cook wrote:
> > > On Tue, Feb 15, 2022 at 11:47:43AM -0600, Gustavo A. R. Silva wrote:
> > > 
> > > These all look trivially correct to me. Only two didn't have the end of
> > > the struct visible in the patch, and checking those showed them to be
> > > trailing members as well, so:
> > > 
> > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > 
> > I'll add this to my -next tree.
> 
> I would like to ask you to send mlx5 patch separately to netdev. We are working
> to delete that file completely and prefer to avoid from unnecessary merge conflicts.

Oh OK. Sure thing; I will do so.

Thanks
--
Gustavo

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

