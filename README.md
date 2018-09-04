# Islandora
Galvin Library Islandora migration scripts

dc_to_mods (both versions) and mods_iitmetadata_combine for preprocessing batch ingests of files migrating from DSpace.

mods_to_dc_subjectsplit replaces Islandora's default mods_to_dc XSL written by Library of Congress which creates Dublin Core from MODS XML.


## Workflow

### ETDs

1. Run Addproquest.xsl against XML file from Proquest (packaged in zip file). *This XML should be renamed proquest.xml.* 
This adds Proquest subject headings to dublin_core.xml (from DSpace).
2. Run dc_to_mods_ir.xml against dublin_core.xml. This transforms Dublin Core to MODS.
3. Run mods_iitmetadata_combine.xsl against newly created MODS XML (from step 2). This adds iit_metadata.xml fields to MODS file.
