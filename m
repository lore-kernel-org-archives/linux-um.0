Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkStr-0002we-LY
 for linux-um@lists.infradead.org; Wed, 02 Dec 2020 14:14:33 +0000
Message-ID: <8a759a5dc560659d7ae00861334e136e015f6b9f.camel@sipsolutions.net>
Subject: Re: [PATCH v2 2/7] um: virtio: use dynamic IRQ allocation
From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 02 Dec 2020 15:14:28 +0100
In-Reply-To: <ecbde0af-49f8-034f-ff74-494dcbea711a@cambridgegreys.com>
References: <20201202115956.42963-1-johannes@sipsolutions.net>
 <20201202125915.d5cbac8ab2de.Id7bf6cf5659579ac53cce88552126e4d98a74e3d@changeid>
 <ecbde0af-49f8-034f-ff74-494dcbea711a@cambridgegreys.com>
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
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org

On Wed, 2020-12-02 at 14:13 +0000, Anton Ivanov wrote:
> 
> > Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> > 
> Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

FWIW, I preserved your ACKs where I didn't change the patches :)

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

