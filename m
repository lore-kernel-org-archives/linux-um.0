Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73884C3DA41
	for <linux-um@archiver.kernel.org>; Thu, 11 Jul 2024 13:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uD5F2KiZ8XLXHAGTMjuR6pDnMDoemCjCwFkeXsnWzb0=; b=GfblbYR9DIO1p9sjFXAmmsWB07
	2iAAveeFm049u2ICEyygjvz1CIQjBzZnexgPUOhm1OZeLFadI1Q8y+hwbrtI/UJC90vhAtXuyUYxl
	gEHV0aZ+st0uArOX+Y7XaVSym/Ww5VVNh70+2CFe4HLCnvs9rTQzcd26erG4n+w6SisnPwcZQMrIo
	oUW4AvfQt9z+G1V3ASulBTjDYYOfbCr4m36Y05+qbJCqC310XMaqnp3w1+oIYD/vSsid6q1PDfSPk
	B0zJv7f7DM5tMGgyiqSry/TOyXrPUi5YeHI5w8vi9i/yWkZpt+WbqWLeZc0yKK/1IsZeAz0XdyhCH
	Q0QTCg+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRtmo-0000000E8y6-0dmt;
	Thu, 11 Jul 2024 13:24:38 +0000
Received: from mgamail.intel.com ([198.175.65.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRtmk-0000000E8w2-3UQR
	for linux-um@lists.infradead.org;
	Thu, 11 Jul 2024 13:24:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720704275; x=1752240275;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w1u81luxRSKXuuP8bL2ZtVySjx/0jxSrRzrfaS7TWpk=;
  b=b2T5IZ2GZdT8ZktxdLJ2cl17QUSO50eTbflFdwejP4/sYogr/tZ2sPb2
   b4yktKZj2Os2lmFTRdP+syQ8I/FGH3Tg4er0J/JYD7ec4zjgUYlLySjkS
   FeqOFbpO/Wg8L0JKiJAdgs2nBW6oY6iNm8hhOxwZq9sTNqhmFQi6ppOcZ
   mY7qzVrf7p+oqcAl410TwfqYisacZDD1UNRDm0D64MQ1bbYlXSLO2ovyZ
   nUSQmOrpHkVPTUwO9fdDxp8Cv9reXDjaM7cVoyI8+xYr0aeamcOA8LEYm
   TzIn07x/OQXPhTLr5OEfEzcpNCYjBPUSN3VzyQ98Qq/9xGlIu9TsZ0vB4
   w==;
X-CSE-ConnectionGUID: BWCMHxT7R+Wh0HOiUvAtyA==
X-CSE-MsgGUID: BS640G0aTACLwpgdLz12SQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="28676505"
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="28676505"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 06:24:33 -0700
X-CSE-ConnectionGUID: w68rnNGyTX+raf3+ra/vZQ==
X-CSE-MsgGUID: xfhpknJGQvakxEtM1SwOLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="53376105"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 11 Jul 2024 06:24:27 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sRtmZ-000ZJz-2y;
	Thu, 11 Jul 2024 13:24:23 +0000
Date: Thu, 11 Jul 2024 21:23:54 +0800
From: kernel test robot <lkp@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	David Hildenbrand <david@redhat.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	linux-um@lists.infradead.org, linux-remoteproc@vger.kernel.org,
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] virtio: fix vq # for balloon
Message-ID: <202407112113.SzSpdDLK-lkp@intel.com>
References: <3d655be73ce220f176b2c163839d83699f8faf43.1720611677.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d655be73ce220f176b2c163839d83699f8faf43.1720611677.git.mst@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240711_062434_949644_D084F737 
X-CRM114-Status: GOOD (  13.79  )
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

Hi Michael,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20240710]
[cannot apply to uml/next remoteproc/rproc-next s390/features linus/master uml/fixes v6.10-rc7 v6.10-rc6 v6.10-rc5 v6.10-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Michael-S-Tsirkin/virtio_balloon-add-work-around-for-out-of-spec-QEMU/20240711-004346
base:   next-20240710
patch link:    https://lore.kernel.org/r/3d655be73ce220f176b2c163839d83699f8faf43.1720611677.git.mst%40redhat.com
patch subject: [PATCH v2 2/2] virtio: fix vq # for balloon
config: i386-randconfig-014-20240711 (https://download.01.org/0day-ci/archive/20240711/202407112113.SzSpdDLK-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240711/202407112113.SzSpdDLK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407112113.SzSpdDLK-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/virtio/virtio_pci_common.c:391:1: error: version control conflict marker in file
     391 | <<<<<<< HEAD
         | ^
>> drivers/virtio/virtio_pci_common.c:392:30: error: use of undeclared identifier 'queue_idx'
     392 |                 vqs[i] = vp_setup_vq(vdev, queue_idx++, vqi->callback,
         |                                            ^
   2 errors generated.


vim +391 drivers/virtio/virtio_pci_common.c

   365	
   366	static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
   367				    struct virtqueue *vqs[],
   368				    struct virtqueue_info vqs_info[])
   369	{
   370		struct virtio_pci_device *vp_dev = to_vp_device(vdev);
   371		int i, err;
   372	
   373		vp_dev->vqs = kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
   374		if (!vp_dev->vqs)
   375			return -ENOMEM;
   376	
   377		err = request_irq(vp_dev->pci_dev->irq, vp_interrupt, IRQF_SHARED,
   378				dev_name(&vdev->dev), vp_dev);
   379		if (err)
   380			goto out_del_vqs;
   381	
   382		vp_dev->intx_enabled = 1;
   383		vp_dev->per_vq_vectors = false;
   384		for (i = 0; i < nvqs; ++i) {
   385			struct virtqueue_info *vqi = &vqs_info[i];
   386	
   387			if (!vqi->name) {
   388				vqs[i] = NULL;
   389				continue;
   390			}
 > 391	<<<<<<< HEAD
 > 392			vqs[i] = vp_setup_vq(vdev, queue_idx++, vqi->callback,
   393					     vqi->name, vqi->ctx,
   394	=======
   395			vqs[i] = vp_setup_vq(vdev, i, callbacks[i], names[i],
   396					     ctx ? ctx[i] : false,
   397	>>>>>>> f814759f80b7... virtio: fix vq # for balloon
   398					     VIRTIO_MSI_NO_VECTOR);
   399			if (IS_ERR(vqs[i])) {
   400				err = PTR_ERR(vqs[i]);
   401				goto out_del_vqs;
   402			}
   403		}
   404	
   405		return 0;
   406	out_del_vqs:
   407		vp_del_vqs(vdev);
   408		return err;
   409	}
   410	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

