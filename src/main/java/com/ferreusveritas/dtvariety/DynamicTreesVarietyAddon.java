package com.ferreusveritas.dtvariety;

import com.ferreusveritas.dynamictrees.api.GatherDataHelper;
import com.ferreusveritas.dynamictrees.api.registry.RegistryHandler;
import com.ferreusveritas.dynamictrees.tree.species.Species;
import net.minecraftforge.eventbus.api.IEventBus;
import net.minecraftforge.fml.common.Mod;
import net.minecraftforge.fml.javafmlmod.FMLJavaModLoadingContext;
import net.minecraftforge.forge.event.lifecycle.GatherDataEvent;

@Mod(DynamicTreesVarietyAddon.MOD_ID)
public class DynamicTreesVarietyAddon {

    public static final String MOD_ID = "dtvariety";

    public DynamicTreesVarietyAddon() {
        final IEventBus modBus = FMLJavaModLoadingContext.get().getModEventBus();

//        ModLoadingContext.get().registerConfig(ModConfig.Type.SERVER, DTPConfigs.SERVER_CONFIG);

//        modBus.addListener(this::clientSetup);
//        modBus.addListener(this::commonSetup);
        modBus.addListener(this::gatherData);

        RegistryHandler.setup(MOD_ID);
    }

//    private void clientSetup(final FMLClientSetupEvent event) {
//        DTPClient.setup();
//    }

//    private void commonSetup(final FMLCommonSetupEvent event) {
//        if (DTConfigs.CANCEL_VANILLA_VILLAGE_TREES.get()) {
//            VillageCactusReplacement.replaceCactiFromVanillaVillages();
//        }
//    }

    private void gatherData(final GatherDataEvent event) {
        GatherDataHelper.gatherAllData(
                MOD_ID,
                event,
                Species.REGISTRY
        );
    }

//    public static ResourceLocation location(final String path) {
//        return new ResourceLocation(MOD_ID, path);
//    }

}
